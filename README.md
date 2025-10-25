# PoE2 Passive Tree Web Planner

A web-based passive skill tree viewer for Path of Exile 2, using the **exact structure from poe2db.tw**.

## Quick Start

```bash
# Start the server
node server.js

# Open browser
http://localhost:8000/
```

That's it! The tree is ready to use.

## Features

✅ **Perfect Copy** - Uses the exact SVG structure from poe2db.tw
✅ **All Nodes** - Complete passive tree with all nodes and connections
✅ **Proper Styling** - Orange notables, yellow keystones, grey normal nodes
✅ **Interactive** - Click to allocate nodes, pan and zoom
✅ **Fast & Responsive** - Smooth panning and zooming

## Project Structure

```
web-planner/
├── index.html              # Main viewer (THE ONLY PAGE YOU NEED)
├── poe2snippet.html        # SVG data from poe2db.tw
├── server.js               # Simple HTTP server
├── START-HERE.md           # Quick start guide
└── README.md               # This file
```

## Controls

- **Pan**: Click and drag anywhere on the tree
- **Zoom**: Mouse wheel to zoom in/out
- **Allocate**: Click on any node to allocate/deallocate it

## Technical Details

### Structure
- Uses exact SVG from poe2db.tw passive tree
- ViewBox centered on main tree area: `-11326, -11389, 23256, 20315`
- All nodes and connections included

### Node Styling
- **Normal nodes**: 40px radius, grey stroke (`#696969`)
- **Notable nodes**: 56px radius, orange stroke
- **Keystone nodes**: 104px radius, yellow stroke
- **Allocated nodes**: Gold fill (`#d4af37`)

### Connections
- Stroke width: 16px
- Grey by default, gold when both connected nodes are allocated
- Uses both `<line>` and `<path>` elements for curved connections

### CSS Classes
- `.normal` - Normal passive nodes
- `.notable` - Notable passive nodes
- `.keystone` - Keystone passive nodes
- `.allocated` - Allocated state (added on click)
- `.active` - Active connection (both nodes allocated)

## Files Explained

### Core Files
- **index.html** - The main and only viewer page with zoom/pan/allocation
- **poe2snippet.html** - The actual SVG from poe2db.tw (1.6MB complete tree data)
- **server.js** - Simple static file server (required for loading the SVG)

### Old Files (Can be deleted)
- `index-old-test.html` - Old test version
- `index-main-tree.html` - Old canvas-based version
- `index-marauder-sample.html` - Old sample version
- `index-poe2.html` - Old attempted recreation
- `index-svg.html` - Old SVG attempt
- `index-direct.html` - Same as current index.html
- `index-real.html` - Old ascendancy test

### Helper Files
- `extract-*.py` - Python scripts for extracting data from tree.lua
- `convert-tree-data.js` - Old converter script
- `src/` - Old JavaScript modules (not used by current index.html)
- `data/` - Old JSON data (not used by current index.html)

## Next Steps

Now that the structure is perfect, you can add:

- [ ] **Skill point tracking** - Count allocated nodes and show skill points used
- [ ] **Path finding** - Validate connections between nodes
- [ ] **Save/load builds** - Store allocated nodes in localStorage or URL
- [ ] **Stats calculation** - Parse and sum stats from allocated nodes
- [ ] **Search nodes** - Find nodes by stat text
- [ ] **Import/export** - Build codes for sharing
- [ ] **Class start nodes** - Highlight starting positions
- [ ] **Ascendancy trees** - Add ascendancy node support
- [ ] **Tooltips** - Better node information display
- [ ] **Mobile support** - Touch controls

## How It Works

1. **index.html** loads **poe2snippet.html** via fetch
2. The SVG is inserted into the DOM
3. JavaScript adds zoom/pan controls via viewBox manipulation
4. Click events toggle the `.allocated` class on nodes
5. Connection highlighting updates when both connected nodes are allocated

### ViewBox Math
```javascript
// Base centered viewBox (from poe2db)
const base = {
  x: -11326.103852910494,
  y: -11389.628444746082,
  width: 23256.18556701031,
  height: 20315.9793814433
};

// Apply zoom and pan
const width = base.width / zoom;
const height = base.height / zoom;
const x = base.x - panX / zoom;
const y = base.y - panY / zoom;

svg.setAttribute('viewBox', `${x} ${y} ${width} ${height}`);
```

## Resources

- [poe2db.tw Passive Tree](https://poe2db.tw/us/passive-skill-tree/) - Original source
- [PathOfBuilding GitHub](https://github.com/PathOfBuildingCommunity/PathOfBuilding) - Data source

---

**Structure is perfect. Ready for feature development!** 🎉
