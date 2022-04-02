// Variables used for Embedded Project 2

// Pinouts
const int RECEIVER = 10;
const int WHITE_LED = 9;

// Decoded zero value
const int ZERO = 22;

const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;

// Used to store value od the button pressed
int button_val;

// Time tracking
unsigned long start_time_ms;
unsigned long reaction_time_ms;
unsigned long delay_time_ms;
unsigned long display_time_ms;

// Flags
int delay_flag = 0;
int display_flag = 0;
int button_flag = 0;

// State Machine Enum
typedef enum
{
  IDLE,
  TIMING_USER,
  DISPLAY_DATA
} state_E;
