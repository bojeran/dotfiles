# Stronger Prints

- Extrusion width / Line width (big difference)
  - \>100% than nozzle size leads to better layer adhesion
    - 110 - 120% conservative -> surface quality stays equal
      - good for external perimeter
    - 140 - 160% can lead to visual imperfections (but mostly works)
      - for internal perimeter relatively safe
    - \>160% works but experimental

- Infill pattern (big difference)
  - **Gyroid** makes the part the same strength in all directions
    - part is little less heavy than with **Grid**
    - good weight to strength ratio
    - print takes 25% longer than the fastest option
  - **Grid, Triangle, Line, Honeycomb, Rectilinear**
    - Good/Better/Best in pressure from top and bottom of the part (in print orientation).
    - Bad with pressure from left and right from the part (in print orientation).
    - For big housings with pressure from top: Use Grid or Line (fast print)
    - For small housings with pressure from top: Triangle is stronger (not much slower to print)
  - **Cubic**
    - Almost equally strong as Gyroid (1-2% stronger)
    - You have Adapative Cubic & Support Cubic options available

  - Conclusion: 
    - Use Cubic for most and for pressure from top (in print orientation) use triangle.
    - Sometimes when Infill Spacing is important for the top layer use Rectilinear/Line/Grid.

- Infill density: 
  - With Grid Infill:
    - Roughly double the strength with every 10% more infill used.
      - 10%: ~0.2kN; 20%: ~0.5kN; 30%: ~1kN; 40%: ~1.8kN; 50%: 2.5kN; 60%: 3.4kN; 70%: 6kN
  - Conclusion: 25% might give good performance to strength

- Wall thickness/Perimeters (also depends on extrusion width)
  - PLA
    - 1mm: 306N; 2mm: 1706N; 3mm: 3062N; 4mm: 4312N; 5mm: 6kN+
  - Conclusion: 3mm gives good ratio

- Fill Infill Spacing with Stuff
  - Sand
  - Old Screws

- Textured 3d-Print
  - Think of folded paper or the side of your washing machine.
    - The texture you are using can increase stiffness significantly especially for thin parts that you often have with 3d-printing
    - It can even counter-act the warping while printing
  - It exists software that can figure out the texture you need to reach certain stifness.
  - With a box: 
    - Vertical Line Pattern is Good.
    - Waffle & Rotated Waffle is Good.
  - With a cylinder:
    - Horizontal line pattern is good

- Remelting can produce an almost perfect part (equally strong as injection molding parts)
  - You can use very fine grain salt, put your part in their and put the whole thing into the ofen with 170 to 230 degress celsius -> wait 1 to 4 hours.
  - You can also use `Annealing in Plaster` (ger. Gips)

- Slicer
  - Perimeter: Inner Outer Inner (Walls printing order)
  - Print Temp: Higher temp is better (max temp -5 degrees is a good formular)

- Screw + Hex-Nut: You can have a screw running through your whole 3d printed part (for bottom to top in printing orientation) with a hex-nut at the end. With this screw and the nex-nut you press the 3d-printed part layers together to great a stronger part.

