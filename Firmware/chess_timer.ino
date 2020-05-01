#include <LiquidCrystal.h>

// Pin naming
#define PLAY_BTN 10
#define MINUS_BTN 9
#define PLUS_BTN 8
#define PLAYER_ONE_BTN 7
#define PLAYER_TWO_BTN 6

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// State variables
boolean configModeActive = false;
boolean plusMinusBtnActive = false;
boolean gameIsRunning = false;
boolean playerOneMoves = true;
boolean playBtnActive = false;
boolean playBtnLongPressActive = false;
String playerOneTime = "00:00";
String playerTwoTime = "00:00";
int editPointer = 0;
int playerOneSeconds = 0;
int playerTwoSeconds = 0;
unsigned long prevMillis = 0;
unsigned long playBtnTimer = 0;
unsigned long playBtnLongPressTime = 300;

void setup() {
  Serial.begin(9600);
  // LCD setup
  lcd.begin(16, 2);
  initClockSeconds();
  display();
  
  // Buttons setup
  pinMode(PLAY_BTN, INPUT);
  pinMode(MINUS_BTN, INPUT);
  pinMode(PLUS_BTN, INPUT);
  pinMode(PLAYER_ONE_BTN, INPUT);
  pinMode(PLAYER_TWO_BTN, INPUT);
}

void loop() {
  playBtnTick();
  plusMinusBtnsTick();
  playerOneBtnTick();
  playerTwoBtnTick();
  updateTimer();
  delay(10);
}

void playBtnTick() {
  if (digitalRead(PLAY_BTN) == HIGH) {
    if (playBtnActive == false) {
      playBtnActive = true;
      playBtnTimer = millis();
    }

    if ((millis() - playBtnTimer > playBtnLongPressTime) && (playBtnLongPressActive == false)) {
      playBtnLongPressActive = true;
      changeMode();
    }
  } else {
    if (playBtnActive == true) {
      if (playBtnLongPressActive == true) {
        playBtnLongPressActive = false;
      } else {
        playBtnClicked();
      }
      playBtnActive = false;
    }
  }
}

void playBtnClicked() {
  if (configModeActive) {
  	moveEditPointer(); 
  } else {
    gameIsRunning = !gameIsRunning;
  }
}

void moveEditPointer() {
  editPointer = (editPointer + 1) % 8;
  display();
}

void changeMode() {
  configModeActive = !configModeActive;
  
  if (configModeActive) {
    
  } else {
    initClockSeconds();
  }
  
  display();
}

void initClockSeconds() {
  playerOneSeconds = timeToSeconds(playerOneTime);
  playerTwoSeconds = timeToSeconds(playerTwoTime);
}

int timeToSeconds(const String& s) {
  return 60 * s.substring(0, 2).toInt() + s.substring(3).toInt();
}

void display() {
  lcd.clear();
  
  if (configModeActive) {
    lcd.setCursor(1, 0);
    lcd.print(playerOneTime);
    
    lcd.setCursor(10, 0);
    lcd.print(playerTwoTime);
    
    lcd.setCursor(cursorOnLcd(), 1);
    lcd.print("^");
  } else {
    lcd.setCursor(0, 0);
    lcd.print("Player1");
    
    lcd.setCursor(9, 0);
    lcd.print("Player2");
    
    lcd.setCursor(1, 1);
    lcd.print(playerOneTime);
    
    lcd.setCursor(10, 1);
    lcd.print(playerTwoTime);
  }
}

int cursorOnLcd() {
  if (editPointer == 0) return 1;
  if (editPointer == 1) return 2;
  if (editPointer == 2) return 4;
  if (editPointer == 3) return 5;
  if (editPointer == 4) return 10;
  if (editPointer == 5) return 11;
  if (editPointer == 6) return 13;
  if (editPointer == 7) return 14;
}

void plusMinusBtnsTick() {
  if (!configModeActive) return;
  
  int minus = digitalRead(MINUS_BTN);
  int plus = digitalRead(PLUS_BTN);
  
  if (minus == HIGH || plus == HIGH) {
    
    if (!plusMinusBtnActive) {
      plusMinusBtnActive = true;
      
      changeCurrentDigitBy(plus == HIGH ? 1 : -1);
    }
  } else {
    plusMinusBtnActive = false;
  }
}

void changeCurrentDigitBy(int add) {
  String& s = editPointer < 4 ? playerOneTime : playerTwoTime;
  int i = editPointer % 4;
  
  if (i > 1) i++;
  s[i] += add;
  if (s[i] > '9') s[i] = '0';
  if (s[i] < '0') s[i] = '9';
  
  if (i == 3 && s[i] > '5') s[i] = '0';
  if (i == 3 && s[i] < '0') s[i] = '5';
  
  display();
}

void playerOneBtnTick() {
  if (digitalRead(PLAYER_ONE_BTN) == HIGH) {
    playerOneMoves = false;
  }
}

void playerTwoBtnTick() {
  if (digitalRead(PLAYER_TWO_BTN) == HIGH) {
    playerOneMoves = true;
  }
}

void updateTimer() {
  if (configModeActive || !gameIsRunning) return;
  
  unsigned long currMillis = millis();
  
  if (currMillis - prevMillis > 1000) {
    prevMillis = currMillis;
    countDown();
  }
}

void countDown() {
  if (playerOneMoves) {
    if (playerOneSeconds > 0) playerOneSeconds--;
    playerOneTime = secondsToTime(playerOneSeconds);
  } else {
    if (playerTwoSeconds > 0) playerTwoSeconds--;
    playerTwoTime = secondsToTime(playerTwoSeconds);
  }
  
  if (playerOneSeconds <= 0 || playerTwoSeconds <= 0) {
    finishGame();
  } else {
    display();
  }
}

void finishGame() {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(String("Player ") + (playerOneSeconds <= 0 ? "2" : "1") + String(" won!"));
  gameIsRunning = false;
  delay(1000);
  reset();
  display();
}

void reset() {
  gameIsRunning = false;
  playerOneTime = "00:00";
  playerTwoTime = "00:00";
  editPointer = 0;
  playerOneSeconds = 0;
  playerTwoSeconds = 0;
}

String secondsToTime(int seconds) {
  int sec = seconds % 60;
  int min = seconds / 60 % 100;
  String s = (sec < 10 ? "0" : "") + String(sec);
  String m = (min < 10 ? "0" : "") + String(min);
  return m + ":" + s;
}



