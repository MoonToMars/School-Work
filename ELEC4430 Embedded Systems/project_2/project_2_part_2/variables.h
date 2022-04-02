// Variables used for Embedded Project 2

// LCD pinout
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;

// Pinout for LED's and receiver's signal line; change these if pinout changes.
const int RECEIVER = 10; // Signal Pin of IR receiver to Pin 5
const int WHITE_LED = 9;
const int RED_LED = 8;
const int GREEN_LED = 7;
const int BLUE_LED = 6;

// IR transmitter dencoding for remote's buttons
const int ZERO = 22;
const int ONE = 12;
const int TWO = 24;
const int THREE = 94;
const int FOUR = 8;

// System variables
int button_val;
int mole_led;
int mole_button;
int score = 0;

// Time tracking 32-bit values
unsigned long start_time_ms;
unsigned long delay_time_ms;


// Flags
int button_flag = 0;
int start_flag = 0;

// State-Machine Enum values
typedef enum
{
  START,
  GAME_ON,
  TIMEOUT,
  INCORRECT,
  RESTARTING
} state_E;
