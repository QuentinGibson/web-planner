# Next Goal: Skill Points & Level Tracking

## Objective

Add an overlay UI that tracks and limits passive point allocation based on character level, just like in the actual game.

## Features to Implement

### 1. **Skill Point Counter**
Display how many skill points the user has spent on the passive tree.

**Requirements:**
- Count allocated nodes (excluding starting class node)
- Display current points used vs. available
- Update in real-time when nodes are clicked

**Example Display:**
```
Points: 15 / 20
```

### 2. **Level Calculation**
Show what character level is required to have the current number of allocated points.

**PoE2 Skill Point Formula:**
- Start with 0 points at level 1
- Gain 1 point per level (levels 2-100)
- Additional points from quests (varies by act/difficulty)

**Base Formula (without quest rewards):**
```
Available Points = Character Level - 1
Required Level = Allocated Points + 1
```

**Example Display:**
```
Required Level: 16
```

### 3. **Point Limit Enforcement**
Prevent users from allocating more points than they have available.

**Requirements:**
- Set maximum skill points (default: 20, adjustable)
- Disable node allocation when limit is reached
- Visual feedback when at limit (red counter, etc.)
- Allow deallocation at any time

**User Controls:**
- Slider or input to set max level (1-100)
- Auto-calculate available points based on level
- Option to include/exclude quest reward points

### 4. **Overlay UI Design**

**Location:** Top-right or bottom-right corner

**Layout:**
```
┌─────────────────────────┐
│  Skill Points Tracker   │
├─────────────────────────┤
│  Points Used: 15 / 20   │
│  Required Level: 16     │
│                         │
│  Max Level: [20  ▼]     │
│  Quest Points: [+8 ☑]   │
└─────────────────────────┘
```

**Styling:**
- Dark semi-transparent background
- Gold accent color for numbers
- Red color when at/over limit
- Matches PoE2 aesthetic

## Implementation Plan

### Phase 1: Basic Counter (MVP)
1. Add HTML overlay element to index.html
2. Track allocated nodes in JavaScript
3. Display simple counter: "Points: X"
4. Update on every node click

### Phase 2: Level Display
1. Calculate required level from allocated points
2. Display: "Required Level: X"
3. Add formula for quest points (optional)

### Phase 3: Point Limiting
1. Add max points setting (default 20)
2. Prevent allocation when limit reached
3. Show visual feedback (red counter, disable clicks)
4. Add level slider (1-100)

### Phase 4: Enhanced UI
1. Create styled overlay panel
2. Add level slider/input
3. Add quest points toggle
4. Add quest point presets per act
5. Add "Reset Tree" button

### Phase 5: Advanced Features (Future)
1. Save/load point limits with builds
2. Show point efficiency (points per stat gained)
3. Path validation (can only allocate connected nodes)
4. Starting class selection (different start nodes)

## Technical Details

### HTML Structure
```html
<div id="points-overlay">
  <h3>Skill Points</h3>
  <div class="points-display">
    <span id="points-used">0</span> / <span id="points-max">20</span>
  </div>
  <div class="level-display">
    Level Required: <span id="level-required">1</span>
  </div>
  <div class="controls">
    <label>Max Level: <input type="number" id="max-level" value="20" min="1" max="100"></label>
    <label><input type="checkbox" id="include-quests" checked> Include Quest Rewards (+8)</label>
  </div>
</div>
```

### CSS Styling
```css
#points-overlay {
  position: fixed;
  top: 20px;
  right: 20px;
  background: rgba(26, 26, 26, 0.95);
  border: 2px solid #3a3a3a;
  border-radius: 8px;
  padding: 20px;
  color: #ccc;
  min-width: 250px;
  z-index: 1000;
}

.points-display {
  font-size: 24px;
  color: #d4af37;
  margin: 10px 0;
}

.points-display.over-limit {
  color: #ff4444;
}
```

### JavaScript Logic
```javascript
let allocatedNodes = new Set();
let maxLevel = 20;
let includeQuests = true;

const QUEST_POINTS = 8; // Total quest reward points in PoE2

function getMaxPoints() {
  const basePoints = maxLevel - 1; // 1 point per level after level 1
  return includeQuests ? basePoints + QUEST_POINTS : basePoints;
}

function updatePointsDisplay() {
  const pointsUsed = allocatedNodes.size;
  const pointsMax = getMaxPoints();
  const requiredLevel = pointsUsed + 1;

  document.getElementById('points-used').textContent = pointsUsed;
  document.getElementById('points-max').textContent = pointsMax;
  document.getElementById('level-required').textContent = requiredLevel;

  // Add over-limit styling
  const display = document.querySelector('.points-display');
  if (pointsUsed > pointsMax) {
    display.classList.add('over-limit');
  } else {
    display.classList.remove('over-limit');
  }
}

function canAllocateNode() {
  return allocatedNodes.size < getMaxPoints();
}

// On node click
circle.addEventListener('click', (e) => {
  const nodeId = e.target.id;

  if (allocatedNodes.has(nodeId)) {
    // Always allow deallocation
    allocatedNodes.delete(nodeId);
    e.target.classList.remove('allocated');
  } else {
    // Check if can allocate
    if (canAllocateNode()) {
      allocatedNodes.add(nodeId);
      e.target.classList.add('allocated');
    } else {
      // Show "at limit" feedback
      flashOverlimit();
    }
  }

  updatePointsDisplay();
  updateConnections();
});
```

## Quest Reward Points by Act

**PoE2 Quest Rewards (estimate):**
- Act 1: 2 skill points
- Act 2: 2 skill points
- Act 3: 2 skill points
- Endgame: 2 skill points
- **Total: ~8 quest points**

*(Exact values may vary - update when confirmed)*

## Success Criteria

✅ User can see how many points they've allocated
✅ User can see what level is required for their allocation
✅ User cannot allocate more points than available
✅ UI is clean and matches PoE2 aesthetic
✅ Point limit is adjustable (via level slider)
✅ Quest points can be toggled on/off

## Future Enhancements

- Path validation (nodes must connect to start)
- Multiple character profiles
- Point allocation history/undo
- Import/export builds with point data
- Comparison mode (compare two builds)
- Stat summary panel
- Point efficiency metrics

## Resources

- [PoE2 Wiki - Passive Skills](https://www.poewiki.net/wiki/Passive_Skill)
- PoE2 Level/Points formula
- Quest reward data

---

**Start with Phase 1 (Basic Counter) and iterate from there!**
