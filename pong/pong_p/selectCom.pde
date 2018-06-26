/**
* Prompts the user to select a com port
* for communication with the arduino
* or other serial device 
*/

/**
* parameters for text size
* and spacing used when
* displaying all the com
* ports
*/
static final int comTextSize = 20;
static final int comTextSpacing = 35;
static final int comTextStart = 70;

void selectCom(){
    textAlign(CENTER);
    background(#044f6f);
    textSize(32);
    fill(#ffffff);
    if(millis() - timer > 3000){
      text("Select COM port" , width/2, 30);
    }
    else{
      text("Unable to connect to device...." , width/2, 30);
    }
    textSize(comTextSize);
    for(int i = 0; i < Serial.list().length; i++){
      if(mouseY < comTextStart + comTextSpacing*i 
       && mouseY > (comTextStart - comTextSize) + comTextSpacing*i){
        if(mousePressed){
          try{
            port = new Serial(this, Serial.list()[i], 9600);
            //Set the text to fit Grayon's code
            textSize(30);
            textAlign(CENTER, CENTER);
          }
          catch(Exception e){
            timer = millis();
            port = null;
          }
        }
        fill(#000000);
        text(Serial.list()[i], width/2, i*35 + 70);
        fill(#ffffff);
      }
      else{
        text(Serial.list()[i], width/2, i*35 + 70);
      }
        
    }
}