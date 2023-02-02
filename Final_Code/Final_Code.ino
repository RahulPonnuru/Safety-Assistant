#include "Wire.h"
#include <MPU6050_light.h>
#include "variables.h"
#include "innit.h"
#include "Flame.h"
#include "Gyro6050.h"
#include "gasSensor.h"

void setup() {
  Serial.begin(115200);
  pinMode(sensor, INPUT);

  //***********************************Fire Setup Done ************************************************************

  Wire.begin();
  byte status = mpu.begin();

#ifdef DEBUG
  Serial.print(F("MPU6050 status: "));
  Serial.println(status);
#endif

  while (status != 0) { }                    // stop everything if could not connect to MPU6050

#ifdef DEBUG
  Serial.println(F("Calculating offsets, do not move MPU6050"));
#endif

  delay(1000);
  mpu.calcOffsets();                         // gyro and accelero

  //*********************************Gyro Sensor Setup Done *******************************************************

  pinMode(Gas_digital, INPUT);

  //*********************************Gas Sensor Done***************************************************************

#ifdef DEBUG
  Serial.print("Connecting to WiFi network ;");
  Serial.print(ssid);
  Serial.println("'...");
#endif

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {

#ifdef DEBUG
    Serial.println("Connecting...");
#endif

    delay(500);
  }

#ifdef DEBUG
  Serial.println("Connected!");
#endif

  twilio = new Twilio(account_sid, auth_token);

  delay(1000);

  bool success = twilio->send_message(to_number, from_number, message, response);
  if (success) {

#ifdef DEBUG
    Serial.println("Sent message successfully!");
#endif

  } else {

#ifdef DEBUG
    Serial.println(response);
#endif

  }
}

void loop() {
  Flame();
  Gyro6050();
  gasSensor();
}
