import matplotlib.pyplot as plt
import numpy as np

# --- Data Setup ---

# Circuit 1: Resistor Bias (Loaded)
q1_v, q1_i = 3.78, 2.80
rac1 = 1.1  # kOhms
# Intercepts
v_cut1 = q1_v + (q1_i * rac1)
i_sat1 = q1_i + (q1_v / rac1)
# Line Points
x1 = np.linspace(0, v_cut1, 100)
y1 = -1/rac1 * (x1 - q1_v) + q1_i

# Circuit 3: Active Load (Loaded)
q3_v, q3_i = 4.63, 2.88
rac3 = 2.2 # kOhms
# Intercepts
v_cut3 = q3_v + (q3_i * rac3)
i_sat3 = q3_i + (q3_v / rac3)
# Line Points
x3_loaded = np.linspace(0, v_cut3, 100)
y3_loaded = -1/rac3 * (x3_loaded - q3_v) + q3_i

# Circuit 3: Active Load (No Load)
rac3_nl = 15.0 # kOhms
# Intercepts
v_cut3_nl = q3_v + (q3_i * rac3_nl) 
i_sat3_nl = q3_i + (q3_v / rac3_nl)
# Line Points (Stop at 18V for visibility)
x3_nl = np.linspace(0, 18, 100) 
y3_nl = -1/rac3_nl * (x3_nl - q3_v) + q3_i

# --- Plotting ---
fig, ax = plt.subplots(figsize=(12, 9))

# 1. Plot Load Lines
ax.plot(x1, y1, label='Resistor Bias (Loaded)', color='#1f77b4', linewidth=2)
ax.plot(x3_loaded, y3_loaded, label='Active Load (Loaded)', color='#2ca02c', linewidth=2)
ax.plot(x3_nl, y3_nl, label='Active Load (No Load)', color='#d62728', linestyle='--', linewidth=2)

# 2. Plot Q-Points
ax.scatter([q1_v], [q1_i], color='black', zorder=10, s=80)
ax.scatter([q3_v], [q3_i], color='black', zorder=10, s=80)

# 3. Add Dotted Guide Lines (Droplines) for Q-Points
# Q1
ax.vlines(q1_v, 0, q1_i, colors='gray', linestyles=':', alpha=0.7)
ax.hlines(q1_i, 0, q1_v, colors='gray', linestyles=':', alpha=0.7)
# Q3
ax.vlines(q3_v, 0, q3_i, colors='gray', linestyles=':', alpha=0.7)
ax.hlines(q3_i, 0, q3_v, colors='gray', linestyles=':', alpha=0.7)

# 4. Add Custom Ticks for Intercepts
# Get current ticks and append our specific values
xticks = list(np.arange(0, 19, 2)) + [v_cut1, v_cut3]
yticks = list(np.arange(0, 8, 1)) + [i_sat1, i_sat3, i_sat3_nl]
ax.set_xticks(xticks)
ax.set_yticks(yticks)

# Format ticks to avoid clutter (rotate x labels slightly)
plt.xticks(rotation=45, fontsize=9)
plt.yticks(fontsize=9)

# 5. Slope Labels
# Calculate midpoints for placement
props = dict(boxstyle='round', facecolor='white', alpha=0.8)
ax.text(1.5, 5.5, f'Slope = -1 / {rac1}kΩ', color='#1f77b4', rotation=-0, bbox=props, verticalalignment='center')
ax.text(8, 1.5, f'Slope = -1 / {rac3}kΩ', color='#2ca02c', rotation=-0, bbox=props, verticalalignment='center')
ax.text(12, 2.5, f'Slope = -1 / {rac3_nl}kΩ', color='#d62728', rotation=-0, bbox=props, verticalalignment='center')

# 6. Annotations for Q-Points
ax.annotate(f'Q1', xy=(q1_v, q1_i), xytext=(q1_v-0.5, q1_i+0.5),
             arrowprops=dict(facecolor='black', arrowstyle='->'), fontweight='bold')
ax.annotate(f'Q3', xy=(q3_v, q3_i), xytext=(q3_v+0.5, q3_i+0.5),
             arrowprops=dict(facecolor='black', arrowstyle='->'), fontweight='bold')

# --- Formatting ---
ax.set_title('AC Load Lines', fontsize=16)
ax.set_xlabel('$V_{CE}$ (Volts)', fontsize=14)
ax.set_ylabel('$I_C$ (mA)', fontsize=14)

# Limits
ax.set_xlim(0, 18)
ax.set_ylim(0, 7)

# Grid and Legend
ax.grid(True, which='both', linestyle='--', alpha=0.4)
ax.legend(loc='upper right', framealpha=0.9, shadow=True, fontsize=11)

plt.tight_layout()
plt.show()