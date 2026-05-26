## 1. Core split

### 3D System (visual + player hit detection)

- Boss model lives in 3D
- Player attacks use **camera raycasts into 3D**
- Weak spots exist as **3D colliders**
- 3D is the **only truth source for player damage**

---

### 2D System (boss combat system)

- All boss attacks exist in **screen-space**
- Telegraphed danger zones are 2D shapes
- Collision is **2D math vs gesture input**
- Boss AI triggers attacks via state events, not physics

---

## 2. Rule of ownership

| System                       | Owns            |
| ---------------------------- | --------------- |
| Player attack validity       | 3D raycasts     |
| Boss attack validity         | 2D screen-space |
| Weak spot detection          | 3D physics      |
| Boss attack visuals + damage | 2D system       |

---

## 3. Input flow

### Tap / thrust

- screen tap → single raycast → 3D boss hit check

### Slash

- gesture path tracked in screen space
- periodic raycasts into 3D based on distance threshold

### Defensive actions

- gesture interacts with 2D telegraph zones only

---

## 4. Boss attack model

Boss does NOT interact with 3D physics for gameplay.

Instead:

- attack state triggers 2D hazard creation
- hazard animates in screen-space
- collision resolved against player gesture data

---

## 5. Weak spots

Two separate roles:

### Gameplay

- 3D collider attached to bone
- only accessed via raycast

### Visual

- projected to screen as point indicator
- no shape projection, no hit logic

---

## 6. Synchronization rule

Only one bridge exists:

- 3D → screen projection for visual alignment only

No reverse mapping.

No gameplay dependency.

---

## 7. Core interaction model

- Player attacks = **3D truth system**
- Boss attacks = **2D rule system**
- Camera = visual alignment only