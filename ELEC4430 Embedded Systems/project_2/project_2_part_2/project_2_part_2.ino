#include <LiquidCrystal.h>
#include "IRremote.h"   // Use latest Version! (V3.6.0)
#include "variables.h"  // This is where we stored most the variables to avoid having magic numbers

// Init objects
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
IRrecv irrecv(RECEIVER);

int determine_mole_button(int mole); // Function to determine which random LED signal we are looking for

void setup() {
  // Initialize leds as output
  pinMode(WHITE_LED, OUTPUT);
  pinMode(RED_LED, OUTPUT);
  pinMode(GREEN_LED, OUTPUT);
  pinMode(BLUE_LED, OUTPUT);

  Serial.begin(9600);         // Start serial communication
  irrecv.enableIRIn();        // Start the receiver
  lcd.begin(16, 2);           // Setup LCD columns and rows
  lcd.print("Game Start");
  delay(5000);
}

void loop() {
  static state_E state = START;   // Init state to idle

  // Check our received IR remote commands
  if (irrecv.decode())
  {
    button_flag = 1;
    button_val = irrecv.decodedIRData.command;
    if (button_val == 0) // Bad reading, ignore input. This usually occurs if the user is blocking the remote.
    {
      button_flag = 0;
    }
    Serial.println(button_val); // Used to see decoded values
  }

  // State machine used to jump between different steps
  switch(state)
  {
    // Ready, set, go at the start of a round
    case START:
      lcd.clear();
      lcd.print("Ready ");
      delay(500);
      lcd.print("Set ");
      delay(500);
      lcd.print("Go");
      delay(500);
      lcd.clear();
      state = GAME_ON;
      break;
    // Used when user had been providing valid inputs
    case GAME_ON:
      if (start_flag == 0)
      {
        mole_led = random(6, 9 + 1);
        mole_button = determine_mole_button(mole_led);
        delay_time_ms = random(2000, 5000 + 1);
        delay(delay_time_ms);
        digitalWrite(mole_led, HIGH);
        start_time_ms = millis(); // Recording moment LED turned on.
        start_flag = 1;           // Gets reset after user has selected the correct input or after restarting the round
        irrecv.resume();          // Only receive single value after LED has been lit. Note, users can click whatever they want until the LED is lit and it won't matter.
      }
      else if (millis() >= (start_time_ms + 2000)) // Timeout condition of 2 seconds
      {
        state = TIMEOUT;
      }
      else if (button_flag & mole_button != button_val) // Check if button has been pressed and if that value is incorrect
      {
        state = INCORRECT;
      }
      else if (button_flag & mole_button == button_val) // Check if button has been pressed and if that value is correct
      {
        score++;
        digitalWrite(mole_led, LOW); // Turn LED off if the user has wacked the correct mole!
        start_flag = 0;
      }
      break;
    case TIMEOUT:
      lcd.clear();
      lcd.print("TimeOut!");
      delay(3000);
      state = RESTARTING;
      break;
    case INCORRECT:
      lcd.clear();
      lcd.print("Incorrect");
      lcd.setCursor(0,1);
      lcd.print("Selection!");
      delay(3000);
      state = RESTARTING;
      break;
    case RESTARTING:
      digitalWrite(mole_led, LOW); //Restart LED's
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Your final score");
      lcd.setCursor(0,1);
      lcd.print ("was: ");
      lcd.print(score);
      delay(5000);
      lcd.clear();
      lcd.print("Restarting...");
      delay(3000);
      score = 0;
      start_flag = 0;
      state = START;
      break;
  }

  button_flag = 0; // Reset button flag so that we do not use previous values
}

// Our decoding function that returns which button needs to be pressed by the user to gain a point
int determine_mole_button(int mole)
{
  if (mole == WHITE_LED)
  {
    mole_button = ONE;
  }
  else if (mole == RED_LED)
  {
    mole_button = TWO;
  }
  else if (mole == GREEN_LED)
  {
    mole_button = THREE;
  }
  else
  {
    mole_button = FOUR;
  }

  return mole_button;
}
