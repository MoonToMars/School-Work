#include <LiquidCrystal.h>
#include "IRremote.h" // Use latest version (3.6.0)
#include "variables.h"

LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
IRrecv irrecv(RECEIVER);  // create instance of 'irrecv'

void setup() {
   // Initialize leds as output
  pinMode(WHITE_LED, OUTPUT);
  Serial.begin(9600);         // Start serial communication
  irrecv.enableIRIn();        // Start the receiver
  lcd.begin(16, 2);           // Setup LCD columns and rows
}

void loop() {
  // init state to idle
  static state_E state = IDLE;

  // Record ir remote value whenever button is pressed
  if (irrecv.decode())
  {
    button_flag = 1;
    button_val = irrecv.decodedIRData.command;
    Serial.println(button_val);
    irrecv.resume();
  }
 
  if (state == IDLE)
  {
    if(delay_flag == 0)
    {
      lcd.clear();
      delay_time_ms = millis() + random(2000, 4000);
      delay_flag = 1;
    }
    else if(millis() >= delay_time_ms)
    {
      delay_flag = 0;
      digitalWrite(WHITE_LED, HIGH);      // Turn on LED
      start_time_ms = millis();           // Record current time as start time
      state = TIMING_USER;                // Go to the next state
    }
  }
  // State used for timing user response
  else if (state == TIMING_USER)
  {
    // Ensure user didn't go over time limit
    if ((millis() - start_time_ms) >= 10000)
    {
      digitalWrite(WHITE_LED, LOW);
      lcd.setCursor(0, 0);                         
      lcd.print("TimeOut!");
      delay(5000);
      state = IDLE;
    }
    else if (button_flag) //Used to check button press time
    {
      if(button_val == ZERO)
      {
        reaction_time_ms = millis() - start_time_ms;// Calculate reaction time
        digitalWrite(WHITE_LED, LOW);               // Turn off LED
        lcd.setCursor(0, 0);                        // Set cursor to start of LCD
        lcd.print(reaction_time_ms);                // Display reaction time in milliseconds
        state = DISPLAY_DATA;
      }
      irrecv.resume();                              // Prepare to recieve next value
    }
  }

  else if (state == DISPLAY_DATA) // State for displaying data
  {
    if (display_flag == 0)
    {
      display_flag = 1;
      display_time_ms = millis() + 5000;
    }
    else if (display_time_ms <= millis())
    {
      display_flag = 0;
      state = IDLE;
    }
  }
  
  button_flag = 0;
}  
