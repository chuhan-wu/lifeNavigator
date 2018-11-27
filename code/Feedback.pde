class Feedback {
  String[] feedback = { "Be honest rather clever.", 
    "Be just to all, but trust not all.", 
    "Believe not all that you see nor half what you hear.", 
    "Beware beginnings.", 
    "By reading we enrich the mind; by conversation we polish it.", 
    "I feel strongly that I can make it.", 
    "Failure is the mother of success. - Thomas Paine", 
    "The unexamined life is not worth living. – Socrates", 
    "Our destiny offers not the cup of despair, but the chalice of opportunity. So let us seize it, not in fear, but in gladness. -- R.M. Nixon", 
    "Living without an aim is like sailing without a compass. -- John Ruskin", 
    "There is no such thing as a great talent without great will - power. – Balzac", 
    "The world is his who enjoys it.", 
    "One should give up anger; one should abandon pride; one should overcome all fetters. I’ll never befall him who clings not to mind and body and is passionless.", 
    "The wise man builds no hopes for the future, entertains no regrets for the past.", 
    "Don’t find fault. Find a remedy.”– Henry Ford, Industrialist.", 
    "To be courageous requires no exceptional qualifications, no magic formula. It’s an opportunity that sooner or later is presented to us all and each person must look for that courage in their own soul.”— John F. Kennedy, 35th U.S. President", 
    "Always bear in mind that your own resolution to succeed is more important than any other one thing.”– Abraham Lincoln, 16th President of the United States", 
    "There is no pressure when you are making a dream come true. – Neymar, Soccer Player", 
    "Optimists are right. Pessimists are right. It’s up to you to choose which you will be. – Harvey Mackay, Business Trainer", 
    "Just as people behave to me, so do I behave to them. When I see that a person despises me and treats me with contempt, I can be as proud as any peacock. – Wolfgang Amadeus Mozart, Musician", 
    "Change does not roll in on the wheels of inevitability, but comes through continuous struggle. – Martin Luther King, Civil Rights Leader", 
    "The secret of change is to focus all of your energy not on fighting the old, but on building the new. – Socrates, Greek Philosopher", 
    "The measure of who we are is what we do with what we have. – Vince Lombardi, American Football Coach", 
    "Time is Money - Benjamin Franklin", 
    "However difficult life may seem, there is always something you can do and succeed at.” – Stephen Hawking, Theoretical Physicist", 
    "It’s kind of fun to do the impossible.”– Walt Disney, Producer", 
    "The problems that exist in the world today cannot be solved by the level of thinking that created them.” — Albert Einstein, Physicist", 
    "Practice makes perfect.", 
    "Always aim for achievement and forget about success.—Helen Hayes", 
    "All things in their being are good for something."
  };
  float x, y;
  int number;
  float speedX = 0.1;
  float incrementX = 0.01;
  boolean mouseover;
  boolean clickOn;


  Feedback(int number, float x, float y) {
    this.number=number;
    this.x=x;
    this.y=y;
  }
  void display() {

    colorMode(RGB);
    fill(200, 20, 20);
    textFont(soup);

    if (clickOn) {
      x = mouseX;
      y = mouseY;
    }

    text(feedback[number], x, y);
  }

  boolean collision(float mouseX, float mouseY) {
    if (mouseX >= x-10 &&         // right of the left edge AND
      mouseX <= x + textWidth(feedback[number])+10 &&    // left of the right edge AND
      mouseY >= y -10 &&         // below the top AND
      mouseY <= y + 50) {    // above the bottom
      return true;
    }
    return false;
  }

  void run() {
    x += speedX;
    speedX += incrementX;
  }
}
