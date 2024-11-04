import java.util.ArrayList;
import java.util.Scanner;

public class MainClass {

    public static void main(String[] args) {
        Team team = new Team();
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine().trim());
        while (n-- > 0) {
            String[] ins = scanner.nextLine().split(" +");
            int adventureId = Integer.parseInt(ins[1]);
            switch (ins[0]) {
                case "1":
                    team.addAdventurer(adventureId, ins[2]);
                    break;
                case "2":
                    team.adventurerAddBottle(adventureId, Integer.parseInt(ins[2]),
                            ins[3], Integer.parseInt(ins[4]), ins[5], Integer.parseInt(ins[6]));
                    break;
                case "3":
                    team.adventurerAddEquipment(adventureId, Integer.parseInt(ins[2]),
                            ins[3], Integer.parseInt(ins[4]), ins[5], Integer.parseInt(ins[6]));
                    break;
                case "4":
                    team.adventurerUpgradeEquipment(adventureId, Integer.parseInt(ins[2]));
                    break;
                case "5":
                    team.adventurerRemoveItem(adventureId, Integer.parseInt(ins[2]));
                    break;
                case "6":
                    team.adventurerEquipItem(adventureId, Integer.parseInt(ins[2]));
                    break;
                case "7":
                    team.adventurerUseItem(adventureId, Integer.parseInt(ins[2]));
                    break;
                case "8":
                    team.adventurerAddFragment(adventureId, Integer.parseInt(ins[2]), ins[3]);
                    break;
                case "9":
                    team.adventurerUseFragment(adventureId, ins[2], Integer.parseInt(ins[3]));
                    break;
                case "10":
                    int k = Integer.parseInt(ins[4]);
                    ArrayList<Integer> arrayList = new ArrayList<>();
                    for (int i = 0; i < k; i++) { arrayList.add(Integer.parseInt(ins[5 + i])); }
                    if ("normal".equals(ins[3])) {
                        team.adventurerNormalAttack(adventureId, ins[2], arrayList);
                    } else { team.adventurerChainAttack(adventureId, ins[2], arrayList); }
                    break;
                case "11":
                    team.adventurerHire(adventureId, Integer.parseInt(ins[2]));
                    break;
                default:
                    team.adventurerChallenge(adventureId);
                    break;
            }
        }
    }
}