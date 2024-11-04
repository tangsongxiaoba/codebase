import org.junit.Test;

import java.util.ArrayList;
import java.util.UUID;

import static java.lang.Math.random;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

public class TeamTest {
    private final Team team = new Team();

    private static int genInt() {
        return (int) (random() * 1000000);
    }

    private static String genString() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    @Test
    public void testAddAdventurer() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        assertEquals(name, team.getAdventurer(id).getName());
    }

    @Test
    public void testGetAdventurerItem() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        int itemId = genInt();
        String bottleName = genString();
        int capacity = genInt();
        String type = "HpBottle";
        HpBottle bo1 = new HpBottle(itemId, bottleName, capacity);
        team.adventurerAddBottle(id, itemId, bottleName, capacity, type, 0);
        assertEquals(bo1.getName(), team.getAdventurerItem(id, itemId).getName());
        itemId = genInt();
        bottleName = genString();
        capacity = genInt();
        type = "AtkBottle";
        int combatEffectiveness = genInt();
        AtkBottle bo2 = new AtkBottle(itemId, bottleName, capacity, combatEffectiveness);
        team.adventurerAddBottle(id, itemId, bottleName, capacity, type, combatEffectiveness);
        assertEquals(bo2.getName(), team.getAdventurerItem(id, itemId).getName());
        itemId = genInt();
        bottleName = genString();
        capacity = genInt();
        type = "DefBottle";
        combatEffectiveness = genInt();
        DefBottle bo3 = new DefBottle(itemId, bottleName, capacity, combatEffectiveness);
        team.adventurerAddBottle(id, itemId, bottleName, capacity, type, combatEffectiveness);
        assertEquals(bo3.getName(), team.getAdventurerItem(id, itemId).getName());
        itemId = genInt();
        bottleName = genString();
        capacity = genInt();
        type = "Axe";
        combatEffectiveness = genInt();
        Equipment eq1 = new Equipment(itemId, bottleName, combatEffectiveness, capacity);
        team.adventurerAddEquipment(id, itemId, bottleName, capacity, type, combatEffectiveness);
        assertEquals(eq1.getName(), team.getAdventurerItem(id, itemId).getName());
        itemId = genInt();
        bottleName = genString();
        capacity = genInt();
        type = "Blade";
        combatEffectiveness = genInt();
        Equipment eq2 = new Equipment(itemId, bottleName, combatEffectiveness, capacity);
        team.adventurerAddEquipment(id, itemId, bottleName, capacity, type, combatEffectiveness);
        assertEquals(eq2.getName(), team.getAdventurerItem(id, itemId).getName());
        itemId = genInt();
        bottleName = genString();
        capacity = genInt();
        type = "Sword";
        combatEffectiveness = genInt();
        Equipment eq3 = new Equipment(itemId, bottleName, combatEffectiveness, capacity);
        team.adventurerAddEquipment(id, itemId, bottleName, capacity, type, combatEffectiveness);
        assertEquals(eq3.getName(), team.getAdventurerItem(id, itemId).getName());
    }

    @Test
    public void testAdventurerUpgradeEquipment() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        int itemId = genInt();
        String eqName = genString();
        int durability = genInt();
        int combatEffectiveness = genInt();
        String type = "Sword";
        team.adventurerAddEquipment(id, itemId, eqName, durability, type, combatEffectiveness);
        team.adventurerUpgradeEquipment(id, itemId);
        assertEquals(durability + 1, team.getAdventurerItem(id, itemId).getAttr());
    }

    @Test
    public void testAdventurerRemoveItem() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        int itemId = genInt();
        String bottleName = genString();
        int capacity = genInt();
        String type = "HpBottle";
        final HpBottle bo1 = new HpBottle(itemId, bottleName, capacity);
        team.adventurerAddBottle(id, itemId, bottleName, capacity, type, 0);
        assertEquals(bo1.getEffectiveness(), team.getAdventurerItem(id, itemId).getEffectiveness());
        team.adventurerRemoveItem(id, itemId);
        assertNull(team.getAdventurerItem(id, itemId));
    }

    @Test
    public void testAdventurerEquipItem() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        int itemId = genInt();
        String bottleName = genString();
        int capacity = genInt();
        String type = "AtkBottle";
        int combatEffectiveness = genInt();
        final AtkBottle bo1 = new AtkBottle(itemId, bottleName, capacity, combatEffectiveness);
        team.adventurerAddBottle(id, itemId, bottleName, capacity, type, combatEffectiveness);
        team.adventurerEquipItem(id, itemId);
        assertNotNull(team.getAdventurer(id).getItemFromBackpack(itemId));
        assertEquals(bo1.getName(), team.getAdventurer(id).getItemFromBackpack(itemId).getName());
    }

    @Test
    public void testAdventurerUseItem() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        int itemId = genInt();
        String bottleName = genString();
        int capacity = genInt();
        int combatEffectiveness = genInt();
        String type = "DefBottle";
        final DefBottle bo3 = new DefBottle(itemId, bottleName, capacity, combatEffectiveness);
        team.adventurerAddBottle(id, itemId, bottleName, capacity, type, combatEffectiveness);
        team.adventurerEquipItem(id, itemId);
        team.adventurerUseItem(id, itemId);
        assertEquals(bo3.getEffectiveness(), team.getAdventurer(id).getDef());
    }

    @Test
    public void testAdventurerAddFragment() {
        int id = genInt();
        int fragmentId = genInt();
        String name = genString();
        String fragmentName = genString();
        team.addAdventurer(id, name);
        team.adventurerAddFragment(id, fragmentId, fragmentName);
        Adventurer adventurer = team.getAdventurer(id);
        assertEquals(fragmentName, adventurer.getFragment(fragmentId).getName());
    }

    @SuppressWarnings("checkstyle:VariableDeclarationUsageDistance")
    @Test
    public void testAdventurerUseFragment() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        int fragmentId = genInt();
        String fragmentName = genString();
        int itemId = genInt();
        String bottleName = genString();
        int capacity = genInt();
        int combatEffectiveness = genInt();
        String type = "DefBottle";
        team.adventurerAddBottle(id, itemId, bottleName, capacity, type, combatEffectiveness);
        team.adventurerUseItem(id, itemId);
        for (int i = 0; i < 10; ++i) {
            team.adventurerAddFragment(id, fragmentId, fragmentName);
            team.adventurerUseFragment(id, fragmentName, itemId);
        }
        int itemId2 = genInt();
        String bottleName2 = genString();
        int capacity2 = genInt();
        int combatEffectiveness2 = genInt();
        String type2 = "Sword";
        team.adventurerAddEquipment(id, itemId2, bottleName2, capacity2,
                type2, combatEffectiveness2);
        team.adventurerEquipItem(id, itemId);
        for (int i = 0; i < 10; ++i) {
            team.adventurerAddFragment(id, fragmentId, fragmentName);
            team.adventurerUseFragment(id, fragmentName, itemId2);
        }
        int wid = genInt();
        String name2 = genString();
        for (int i = 0; i < 10; ++i) {
            team.adventurerAddFragment(id, genInt(), name2);
            team.adventurerUseFragment(id, name2, wid);
        }
    }

    @Test
    public void testAdventurerNormalAttack() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        ArrayList<Integer> adventurers = new ArrayList<>();
        for (int i = 1; i < 10; ++i) {
            int idf = genInt();
            String namef = genString();
            adventurers.add(idf);
            team.addAdventurer(idf, namef);
        }
        Adventurer adv = team.getAdventurer(id);

        int swordId = genInt();
        String swordName = genString();
        int swordDurability = genInt();
        int swordCombatEffectiveness = genInt();
        adv.addItem(new Sword(swordId, swordName, swordCombatEffectiveness, swordDurability));
        team.adventurerNormalAttack(id, swordName, adventurers);
        adv.equipItem(swordId);
        team.adventurerNormalAttack(id, swordName, adventurers);

        int axeId = genInt();
        String axeName = genString();
        int axeDurability = genInt();
        int axeCombatEffectiveness = genInt();
        adv.addItem(new Axe(axeId, axeName, axeCombatEffectiveness, axeDurability));
        team.adventurerNormalAttack(id, axeName, adventurers);
        adv.equipItem(axeId);
        team.adventurerNormalAttack(id, axeName, adventurers);

        int bladeId = genInt();
        String bladeName = genString();
        int bladeDurability = genInt();
        int bladeCombatEffectiveness = genInt();
        adv.addItem(new Blade(bladeId, bladeName, bladeCombatEffectiveness, bladeDurability));
        team.adventurerNormalAttack(id, bladeName, adventurers);
        adv.equipItem(bladeId);
        team.adventurerNormalAttack(id, bladeName, adventurers);
    }

    @Test
    public void testAdventurerChainAttack() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        ArrayList<Integer> adventurers = new ArrayList<>();
        for (int i = 1; i < 10; ++i) {
            int idf = genInt();
            String namef = genString();
            adventurers.add(idf);
            team.addAdventurer(idf, namef);
        }
        Adventurer adv = team.getAdventurer(id);
        int swordId = genInt();
        String swordName = genString();
        int swordDurability = genInt();
        int swordCombatEffectiveness = genInt();
        adv.addItem(new Sword(swordId, swordName, swordCombatEffectiveness, swordDurability));
        team.adventurerChainAttack(id, swordName, adventurers);
        adv.equipItem(swordId);
        team.adventurerChainAttack(id, swordName, adventurers);

        int axeId = genInt();
        String axeName = genString();
        int axeDurability = genInt();
        int axeCombatEffectiveness = genInt();
        adv.addItem(new Axe(axeId, axeName, axeCombatEffectiveness, axeDurability));
        team.adventurerChainAttack(id, axeName, adventurers);
        adv.equipItem(axeId);
        team.adventurerChainAttack(id, axeName, adventurers);

        int bladeId = genInt();
        String bladeName = genString();
        int bladeDurability = genInt();
        int bladeCombatEffectiveness = genInt();
        adv.addItem(new Blade(bladeId, bladeName, bladeCombatEffectiveness, bladeDurability));
        team.adventurerChainAttack(id, bladeName, adventurers);
        adv.equipItem(bladeId);
        team.adventurerChainAttack(id, bladeName, adventurers);
    }

    @Test
    public void testAdventurerHire() {
        int id = genInt();
        int id2 = genInt();
        String name = genString();
        String name2 = genString();
        team.addAdventurer(id, name);
        team.addAdventurer(id2, name2);
        team.adventurerHire(id, id2);
    }

    @Test
    public void testAdventurerChallenge() {
        int id = genInt();
        String name = genString();
        team.addAdventurer(id, name);
        team.adventurerChallenge(id);
    }
}