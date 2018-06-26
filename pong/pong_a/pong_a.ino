const int p1 = A1; //player one analog input
const int p2 = A0; //player two analog input

int p1Value = 0;
int p2Value = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {

  Serial.flush();

  p1Value = analogRead(p1);
  delay(5);
  p2Value = analogRead(p2);
  delay(5);

  Serial.print(p1Value);
  Serial.print(",");
  Serial.print(p2Value);
  Serial.print("\n");

  delay(20);
}
