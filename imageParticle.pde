PImage imgJaga;
int intervalOfPixels = 10;
color[][] pointColor;
int iW, iH;

void setup() {
  size(800, 800, P3D);
  imgJaga = loadImage("fall.jpg");
  iW = imgJaga.width;
  iH = imgJaga.height;
  pointColor = new color[iW][iH];
  for(int i = 0; i < iW; i += 1){
    for(int j = 0; j < iH; j += 1){
      color c =imgJaga.pixels[j * iW + i];
      pointColor[i][j] = c;
    }
  }
  // size(iW, iH, P3D);
  loadPixels();
  noStroke();
  // frameRate(30);
}

void draw() {
  lights();
  background(255,255,255,0);
  ambientLight(40, 40, 40);  //環境光を当てる
  lightSpecular(60, 60, 60);    //光の鏡面反射色（ハイライト）を設定
  directionalLight(200, 200, 200, 0, 0, -1);    //指向性ライトを設定
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), iW/2.0, iH/2.0, 0, 0, 1, 0);
  // lightSpecular(5, 0, 0);
  // rotate(radians(random(-180, 180)), radians(30), 0, 0);
  shininess(1.0);
  int baseNoise = frameCount;
  for(int i = 0; i < iW; i += intervalOfPixels){
    for(int j = 0; j < iH; j += intervalOfPixels){
      shininess(20.0*cos(sin(baseNoise/10.0) + i/10.0 * width*j/10.0) + 20.0);
      fill(pointColor[i][j]);
      specular(pointColor[i][j]);
      pushMatrix();
      translate(i, j, 0);
      translate(5.0*noise(cos(baseNoise/10.0) + i/5.0 + width*j), 5.0*noise(sin(baseNoise/10.0) + i + width*j/15.0), 0);
      sphere(5);
      popMatrix();
    }
  }
  // intervalOfPixels++;
}
