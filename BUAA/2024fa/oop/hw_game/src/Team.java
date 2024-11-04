import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Objects;

class Team {
    private final ArrayList<Adventurer> adventurers;

    Team() {
        this.adventurers = new ArrayList<>();
    }

    public void addAdventurer(int id, String name) {
        adventurers.add(new Adventurer(id, name));
    }

    public Adventurer getAdventurer(int id) {
        for (Adventurer adventurer : adventurers) {
            if (adventurer.getId() == id) {
                return adventurer;
            }
        }
        return null;
    }

    public Item getAdventurerItem(int id, int itemId) {
        for (Adventurer adventurer : adventurers) {
            if (adventurer.getId() == id) {
                return adventurer.getItemById(itemId);
            }
        }
        return null;
    }

    public void adventurerAddBottle(int adventurerId, int bottleId, String bottleName,
                                    int capacity, String type, int combatEffectiveness) {
        Adventurer adventurer = getAdventurer(adventurerId);
        if (adventurer != null) {
            if (Objects.equals(type, "HpBottle")) {
                adventurer.addItem(new HpBottle(bottleId, bottleName, capacity));
            } else if (Objects.equals(type, "AtkBottle")) {
                adventurer.addItem(new AtkBottle(bottleId, bottleName,
                        capacity, combatEffectiveness));
            } else if (Objects.equals(type, "DefBottle")) {
                adventurer.addItem(new DefBottle(bottleId, bottleName,
                        capacity, combatEffectiveness));
            }
        }
    }

    public void adventurerAddEquipment(int adventurerId, int equipmentId, String equipmentName,
                                       int durability, String type, int combatEffectiveness) {
        Adventurer adventurer = getAdventurer(adventurerId);
        if (adventurer != null) {
            if (Objects.equals(type, "Axe")) {
                adventurer.addItem(new Axe(equipmentId,
                        equipmentName, combatEffectiveness, durability));
            } else if (Objects.equals(type, "Blade")) {
                adventurer.addItem(new Blade(equipmentId,
                        equipmentName, combatEffectiveness, durability));
            } else if (Objects.equals(type, "Sword")) {
                adventurer.addItem(new Sword(equipmentId,
                        equipmentName, combatEffectiveness, durability));
            }
        }
    }

    public void adventurerAddFragment(int adventuererId, int fragmentId, String fragmentName) {
        Adventurer adventurer = getAdventurer(adventuererId);
        if (adventurer != null) {
            adventurer.addFragment(new Fragment(fragmentId, fragmentName));
        }
    }

    public void adventurerUpgradeEquipment(int adventurerId, int equipmentId) {
        Adventurer adventurer = getAdventurer(adventurerId);
        if (adventurer != null) {
            Equipment equipment = adventurer.upgradeEquipment(equipmentId);
            System.out.println(equipment.getName() + " " + equipment.getAttr());
        }
    }

    public void adventurerRemoveItem(int adventurerId, int itemId) {
        Adventurer adventurer = getAdventurer(adventurerId);
        if (adventurer != null) {
            Item item = adventurer.removeItem(itemId);
            System.out.println(item.getClass().getName() + " " +
                            item.getName() + " " + item.getAttr());
        }
    }

    public void adventurerEquipItem(int adventurerId, int itemId) {
        Adventurer adventurer = getAdventurer(adventurerId);
        if (adventurer != null) {
            adventurer.equipItem(itemId);
        }
    }

    public void adventurerUseItem(int adventurerId, int itemId) {
        Adventurer adventurer = getAdventurer(adventurerId);
        String resStr = "";
        if (adventurer != null) {
            resStr += adventurer.getName();
            boolean res = adventurer.useItem(itemId);
            if (res) {
                resStr += " " + adventurer.getHitPoint() + " " +
                        adventurer.getAtk() + " " + adventurer.getDef();
            } else {
                resStr += " fail to use " + adventurer.getItemById(itemId).getName();
            }
        }
        System.out.println(resStr);
    }

    public void adventurerUseFragment(int adventuererId, String fragmentName, int welfareId) {
        Adventurer adventurer = getAdventurer(adventuererId);
        String resStr = "";
        if (adventurer != null) {
            int cnt = adventurer.getFragmentCount(fragmentName);
            if (cnt < 5) {
                resStr += cnt + ": Not enough fragments collected yet";
            } else {
                boolean res = adventurer.getWelfare(welfareId);
                if (!res) {
                    HpBottle bottle = new HpBottle(welfareId, fragmentName, 100);
                    adventurer.addItem(bottle);
                    resStr += "Congratulations! HpBottle " + fragmentName + " acquired";
                } else {
                    Item item = adventurer.getItemById(welfareId);
                    resStr += item.getName() + " " + item.getAttr();
                }
                cnt = 0;
                while (cnt < 5 && adventurer.deleteFragment(fragmentName)) {
                    cnt += 1;
                }
            }
        }
        System.out.println(resStr);
    }

    public void adventurerNormalAttack(int attackerId, String equipmentName,
                                       ArrayList<Integer> adventurersId) {
        Adventurer attacker = getAdventurer(attackerId);
        StringBuilder res = new StringBuilder();
        if (attacker != null) {
            int maxDef = -1;
            int ce = 0;
            boolean check = false;
            for (int adv : adventurersId) {
                Adventurer adventurer = getAdventurer(adv);
                if (adventurer.getDef() > maxDef) { maxDef = adventurer.getDef(); }
            }
            Item item = attacker.getEquipmentFromBackpackByName(equipmentName);
            if (item != null) {
                ce = attacker.getAtk() + item.getEffectiveness();
                if (ce > maxDef) { check = true; }
            }
            if (check) {
                item.setAttr(item.getAttr() - 1);
                if (item.getAttr() == 0) {
                    attacker.removeItem(item.getId());
                }
                for (int adv : adventurersId) {
                    Adventurer adventurer = getAdventurer(adv);
                    adventurer.getAttacked((Equipment) item, ce);
                    res.append(adventurer.getName()).append(" ").
                            append(adventurer.getHitPoint()).append("\n");
                }
                res.deleteCharAt(res.length() - 1);
            } else {
                res.append("Adventurer ").append(attackerId).append(" defeated");
            }
        }
        System.out.println(res);
    }

    public void adventurerChainAttack(int attackerId, String equipmentName,
                                       ArrayList<Integer> adventurersId) {
        Adventurer attacker = getAdventurer(attackerId);
        String res = "";
        if (attacker != null) {
            HashSet<Adventurer> victims = new HashSet<>();
            HashSet<Adventurer> employees = new HashSet<>();
            adventurersId.forEach(id -> victims.add(getAdventurer(id)));
            for (int i = 0; i < 4; ++i) {
                victims.forEach(v -> employees.addAll(v.getEmployees()));
                victims.addAll(employees);
            }
            int maxDef = -1;
            for (Adventurer v : victims) {
                if (v.getDef() > maxDef) { maxDef = v.getDef(); }
            }
            int ce = 0;
            boolean check = false;
            Item item = attacker.getEquipmentFromBackpackByName(equipmentName);
            if (item != null) {
                ce = attacker.getAtk() + item.getEffectiveness();
                if (ce > maxDef) { check = true; }
            }
            if (check) {
                int sum = 0;
                item.setAttr(item.getAttr() - 1);
                if (item.getAttr() == 0) {
                    attacker.removeItem(item.getId());
                }
                for (Adventurer v : victims) {
                    int hp = v.getHitPoint();
                    if (item instanceof Axe) {
                        v.setHitPoint(hp / 10);
                    } else if (item instanceof Sword) {
                        v.setHitPoint(hp - (ce - v.getDef()));
                    } else {
                        v.setHitPoint(hp - ce);
                    }
                    int hp2 = v.getHitPoint();
                    sum += hp - hp2;
                }
                res += sum;
            } else {
                res += "Adventurer " + attackerId + " defeated";
            }
        }
        System.out.println(res);
    }

    public void adventurerHire(int hirerId, int employeeId) {
        Adventurer hirer = getAdventurer(hirerId);
        Adventurer employee = getAdventurer(employeeId);
        employee.hiredByAdventurer(hirer);
        hirer.employAdventurer(employee);
    }

    public void adventurerChallenge(int id) {
        int ce = 0;
        int cnt = 1;
        Adventurer adventurer = getAdventurer(id);
        ce += adventurer.getCombatEffectiveness();
        HashMap<Integer, Item> backpack = adventurer.getBackpack();
        for (Item item : backpack.values()) {
            ce += item.getCombatEffectiveness();
        }
        ArrayList<Adventurer> employees = adventurer.getEmployees();
        for (Adventurer employee : employees) {
            ce += employee.getCombatEffectiveness();
            cnt += 1;
        }
        String[] str = {"", "Cloak of Shadows", "Flamebrand Sword",
            "Stoneheart Amulet", "Windrunner Boots", "Frostbite Staff"};
        int[] add = {0, 40, 40, 40, 30, 50};
        int[] type = {1, 1, 0, 1, 1, 0};
        for (int i = 1; i <= 5; ++i) {
            int monster = 1000 * i;
            if (ce > monster) {
                System.out.println(str[i]);
                ce += add[i] * cnt;
                if (type[i] == 1) {
                    adventurer.setDef(adventurer.getDef() + add[i]);
                    for (Adventurer employee : employees) {
                        employee.setDef(employee.getDef() + add[i]);
                    }
                } else {
                    adventurer.setAtk(adventurer.getAtk() + add[i]);
                    for (Adventurer employee : employees) {
                        employee.setAtk(employee.getAtk() + add[i]);
                    }
                }
            } else {
                break;
            }
        }
    }

}
