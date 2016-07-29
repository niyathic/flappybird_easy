public class Environment {
  float GROUNDTOP = height - 80;
  Ground ground;
  Tube tubeA;
  Tube tubeB;
  float tick = 0;
  float speed = 3;
  int tubesPassed = 0;
  PFont font;

  public Environment() {
    ground = new Ground();
    tubeA = new Tube(tick);
    tubeB = new Tube(tick + width);
  }

  public void draw() {
    tubeA.draw();
    tubeB.draw();
    ground.draw();
  }

  public void update() {
    ground.update(tick);
    tubeA.update(tick);
    tubeB.update(tick);
    tick = (tick + speed);
  }

  private class Tube {
    PImage imgTop;
    PImage imgBottom;
    float x;
    float gapHeight = 100;
    float startTick;
    float gapTopY;

    public Tube (float start) {
      imgTop = loadImage("assets/Green Tube Inverted.png");
      imgBottom = loadImage("assets/Green Tube.png");
      x = width*2;
      restart(start);
    }

    private void restart(float tick) {
      startTick = tick;
      gapTopY = (GROUNDTOP - gapHeight)/2 + random(-50,50);
    }

    public void draw() {
      image(imgTop, x, gapTopY - imgTop.height);
      image(imgBottom, x, gapTopY + gapHeight);
    }

    public void update(float tick) {
      x = startTick - tick + width*2;

      if(x < -imgTop.width) {
        restart(tick);
      }

      boolean inside = bird.getX() + bird.getWidth() > x && bird.getX() < x + imgTop.width;
      boolean between = bird.getY() > gapTopY && bird.getY() < gapTopY + gapHeight - bird.getHeight();
      if(inside && !between) {
        bird.kill();
        speed = 0;
        tubesPassed = 0;
      }
      if(inside && between) {
        tubesPassed ++;
      }

    }
  }

  private class Ground {
    PImage img;
    float y;
    float x;

    public Ground () {
      img = loadImage("assets/Ground.png");
      y = GROUNDTOP;
      x = 0;
    }

    public void draw() {
      image(img, x, y);
      image(img, x + img.width, y);
    }

    public void update(float tick) {
      x = (0 - tick) % img.width;
      if(bird.getY() + bird.getHeight() >= y) {
        bird.kill();
        speed = 0;
        tubesPassed = 0;
      }
      if(bird.getY() < 0) {
        bird.kill();
        speed = 0;
        tubesPassed = 0;
      }
      font = loadFont("CalistoMT-32.vlw");
      textFont(font);
      text(tubesPassed/85,10,30);
      fill(255,255,255);
    }
  }
}