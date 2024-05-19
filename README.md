
# **Measure**

Measure is an iOS application that allows you to measure the roll or tilt angle of your device using the built-in gyroscope. It is useful for measuring the tilt of surfaces or objects and can be particularly useful in contexts such as construction, DIY, and photography.

### **Screenshots**

<div style="display: flex;">
  <img src="https://github.com/FrancescaFerrini/Measure/assets/75753679/cafaa076-edbc-4b1d-a996-2c1dbf7d63ef" width="700" />
</div>


<div style="display: flex;">
   <img src="https://github.com/FrancescaFerrini/Measure/assets/75753679/738747fe-654c-43d7-82ac-088fb9454787" width="300" />
   <img src="https://github.com/FrancescaFerrini/Measure/assets/75753679/60ed132c-5d48-4825-b271-538726c8b309" width="300" />
</div>


### **Project Origin**
This project began as part of a learning path to gain skills in iOS application development using the Swift programming language and frameworks provided by Apple. The idea to create a measurement application was inspired by the Measure app built into iPhone devices, which provides leveling and measurement tools based on augmented reality (AR).


### **Application structure:**

- **ContentView**: The main screen of the application showing the AR view for measurement. It uses ARKit and RealityKit to create an augmented reality experience to detect and visualize horizontal surfaces.
- **LevelView**: A view that shows the pitch or roll angle of the device using data provided by the built-in gyroscope. This view is designed to emulate a digital level.
- **TabController**: A tab controller that manages navigation between the ContentView and LevelView screens.


### **Frameworks used:**
- **SwiftUI**: Used for creating the application user interface in a declarative and responsive manner.
- **ARKit**: Used for augmented reality integration, enabling the application to detect and visualize horizontal surfaces in three-dimensional space.
- **CoreMotion**: Used for accessing data from the device's gyroscope, which is needed to calculate pitch and roll angle in the LevelView view.

### **Haptic feedback**
In the LevelView view, the application uses haptic feedback to provide a haptic response to the user when the device is in a horizontal position. When the pitch or roll angle approaches zero, haptic feedback is generated to indicate that the device is properly aligned.



