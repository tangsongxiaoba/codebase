import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

class Adventurer extends Combat {
    private final HashMap<Integer, Item> backpack;
    private final HashMap<Integer, Item> storage;
    private final ArrayList<Fragment> fragments;
    private final HashMap<Adventurer, Integer> hirers;
    private final ArrayList<Adventurer> employees;

    private int hitPoint;
    private int atk;
    private int def;
    private int maxBottles;

    public Adventurer(int id, String name) {
        super(id, name, 1);
        this.storage = new HashMap<>();
        this.backpack = new HashMap<>();
        this.fragments = new ArrayList<>();
        this.hirers = new HashMap<>();
        this.employees = new ArrayList<>();
        this.hitPoint = 500;
        this.atk = 1;
        this.def = 0;
        this.maxBottles = 1;
    }

    public int getHitPoint() {
        return hitPoint;
    }

    public void setHitPoint(int hitPoint) {
        this.hitPoint = hitPoint;
    }

    public int getAtk() {
        return atk;
    }

    public void setAtk(int atk) {
        this.atk = atk;
    }

    public int getDef() {
        return def;
    }

    public void setDef(int def) {
        this.def = def;
    }

    @Override
    public int getCombatEffectiveness() {
        setCombatEffectiveness(atk + def);
        return super.getCombatEffectiveness();
    }

    public ArrayList<Adventurer> getEmployees() {
        return employees;
    }

    public HashMap<Integer, Item> getBackpack() {
        return backpack;
    }

    public int getFragmentCount(String name) {
        int cnt = 0;
        for (Fragment fragment : fragments) {
            if (fragment.getName().equals(name)) {
                cnt += 1;
            }
        }
        return cnt;
    }

    public int getMaxBottles() {
        return maxBottles = getCombatEffectiveness() / 5 + 1;
    }

    public void addItem(Item item) {
        storage.put(item.getId(), item);
    }

    public void addFragment(Fragment fragment) {
        fragments.add(fragment);
    }

    public void equipItem(int id) {
        if (storage.containsKey(id)) {

            Item item = storage.get(id);

            if (item instanceof Equipment) {
                String name = item.getName();
                for (Item item2 : backpack.values()) {
                    if ((item2 instanceof Equipment) && item2.getName().equals(name)) {
                        storage.put(item2.getId(), item2);
                        backpack.remove(item2.getId());
                        break;
                    }
                }
            } else if (item instanceof Bottle) {
                String name = item.getName();
                int cnt = 0;
                for (Item item2 : backpack.values()) {
                    if ((item2 instanceof Bottle) && item2.getName().equals(name)) {
                        cnt += 1;
                        if (cnt >= getMaxBottles()) {
                            return;
                        }
                    }
                }
            }

            backpack.put(id, item);
            storage.remove(id);
        }
    }

    public Fragment getFragment(int id) {
        for (Fragment fragment : fragments) {
            if (fragment.getId() == id) {
                return fragment;
            }
        }
        return null;
    }

    public Item getItemById(int id) {
        if (backpack.containsKey(id)) {
            return backpack.get(id);
        }
        return storage.get(id);
    }

    public Item getItemFromBackpack(int id) {
        return backpack.get(id);
    }

    public Item getEquipmentFromBackpackByName(String name) {
        for (Item item : backpack.values()) {
            if (item instanceof Equipment && item.getName().equals(name)) {
                return item;
            }
        }
        return null;
    }

    public Equipment upgradeEquipment(int equipmentId) {
        Equipment equipment = (Equipment) getItemById(equipmentId);
        if (equipment != null) {
            equipment.setAttr(equipment.getAttr() + 1);
        }
        return equipment;
    }

    public Item removeItem(int id) {
        Item item = getItemById(id);
        storage.remove(id);
        backpack.remove(id);
        return item;
    }

    public boolean useItem(int id) {
        Item item = getItemFromBackpack(id);
        if (item instanceof Bottle) {
            if (((Bottle) item).isEmpty()) {
                removeItem(item.getId());
                return true;
            }
            if (item instanceof HpBottle) {
                this.hitPoint += item.getEffectiveness();
            } else if (item instanceof AtkBottle) {
                this.atk += item.getEffectiveness();
            } else if (item instanceof DefBottle) {
                this.def += item.getEffectiveness();
            } else {
                return false;
            }
            setCombatEffectiveness(atk + def);
            getMaxBottles();
            ((Bottle) item).setEmpty(true);
        } else {
            return false;
        }
        return true;
    }

    public boolean getWelfare(int welfareId) {
        Item item = getItemById(welfareId);
        if (item != null) {
            if (item instanceof Bottle) {
                if (((Bottle) item).isEmpty()) {
                    ((Bottle) item).setEmpty(false);
                }
            } else if (item instanceof Equipment) {
                item.setAttr(item.getAttr() + 1);
            }
            return true;
        }
        return false;
    }

    public boolean deleteFragment(String name) {
        for (Fragment fragment : fragments) {
            if (fragment.getName().equals(name)) {
                fragments.remove(fragment);
                return true;
            }
        }
        return false;
    }

    public void hiredByAdventurer(Adventurer adventurer) {
        hirers.put(adventurer, 0);
    }

    public void employAdventurer(Adventurer adventurer) {
        employees.add(adventurer);
    }

    public boolean assist(Adventurer hirer) {
        Iterator<Map.Entry<Integer, Item>> it = backpack.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<Integer, Item> entry = it.next();
            Item item = entry.getValue();
            if (item instanceof Equipment) {
                it.remove();
                hirer.addItem(item);
            }
        }
        if (this.hirers.get(hirer) != null) {
            int assistCnt = this.hirers.get(hirer) + 1;
            if (assistCnt > 3) {
                this.hirers.remove(hirer);
                return false;
            } else {
                this.hirers.put(hirer, assistCnt);
                return true;
            }
        }
        return false;
    }

    public void getAttacked(Equipment equipment, int combatEffectiveness) {
        int hp = getHitPoint();
        if (equipment instanceof Axe) {
            setHitPoint(hp / 10);
        } else if (equipment instanceof Blade) {
            setHitPoint(hp - combatEffectiveness);
        } else {
            setHitPoint(hp - (combatEffectiveness - getDef()));
        }
        int hp2 = getHitPoint();
        if (hp2 <= hp / 2) {
            employees.removeIf(e -> !e.assist(this));
        }
    }

}
