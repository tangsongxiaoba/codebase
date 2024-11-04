class Player {
    private final Pet pet;
    private int exp;

    public Player(Pet pet) {
        this.pet = pet;
        exp = 0;
    }

    public void feedPet(String foodName) {
        pet.eat(foodName);
        int feedExp = 5;
        exp += feedExp;
    }

    public void playWithPet() {
        pet.play();
        int playExp = 7;
        exp += playExp;
    }

    public void checkPetStatus() {
        pet.printStatus();
    }

    public void printStatus() {
        System.out.println("Final Player Exp: " + exp);
    }
}