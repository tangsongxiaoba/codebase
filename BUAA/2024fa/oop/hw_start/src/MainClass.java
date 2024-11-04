import java.util.Scanner;

public class MainClass {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        String name = scanner.nextLine();
        int hunger = scanner.nextInt();
        int happiness = scanner.nextInt();
        int health = scanner.nextInt();

        Pet pet = new Pet(name, hunger, happiness, health);

        Player player = new Player(pet);

        while (true) {
            String command = scanner.next();
            if ("quit".equals(command)) {
                break;
            } else if ("feed".equals(command)) {
                String foodName = scanner.next();
                player.feedPet(foodName);
            } else if ("play".equals(command)) {
                player.playWithPet();
            } else if ("status".equals(command)) {
                player.checkPetStatus();
            }
        }

        print(pet, player);

    }

    private static void print(Pet pet, Player player) {
        pet.printStatus();
        System.out.println();
        player.printStatus();
        System.out.println();
        System.out.println("Thank you for playing!");
    }
}
