// Made by Niyathi Chakrapani and Salvatore T

PImage scene;
Bird bird;
Environment environment;

void setup() {
    size(288, 511);
    scene = loadImage("assets/Day Background.png");
    initialize();
}

void draw() {
    // Draw the scene
    image(scene, 0, -50, width, height);

    // Update the environment
    bird.update();
    environment.update();

    // Draw the assets
    environment.draw();
    bird.draw();

    if(bird.isDead()) {
        initialize();
    }
}

void mousePressed() {
    bird.click();
}

void keyPressed() {
    bird.click();
}

void initialize() {
    bird = new Bird(width/5, height/3);
    environment = new Environment();
}

public class Bird {
    PImage up, middle, down;
    PImage[] imageStates;
    float x, y;
    float flapProgress;
    float flapSpeed = 0.2;
    float yVelocity;
    float yAcceleration;
    float flapVelocity;

    public Bird(float x, float y) {
        this.x = x;
        this.y = y;
        yVelocity = 0;
        yAcceleration = 0.06;
        flapVelocity = -2;
        up = loadImage("assets/Purple Up.png");
        middle = loadImage("assets/Purple Middle.png");
        down = loadImage("assets/Purple Down.png");
        imageStates = new PImage[]{up, middle, down, middle};
        flapProgress = 0;
    }

    public void draw() {
        image(imageStates[floor(flapProgress)], x, y);
        flapProgress = (flapProgress + flapSpeed) % 4;
    }

    public void kill() {
        flapSpeed = 0;
        yVelocity = 0;
        yAcceleration = 0;
        flapVelocity = 0;
    }

    public boolean isDead() { return flapSpeed == 0.0; }

    public void update() {
        y += yVelocity;
        yVelocity += yAcceleration;
    }

    public void click() {
        yVelocity = flapVelocity;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public float getWidth() {
        return up.width;
    }

    public float getHeight() {
        return up.height;
    }
}