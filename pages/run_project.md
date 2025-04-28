# Run the project

To run the project, follow these steps:

1. Open the project in **Godot 4.4**.
2. Go to Debug tab, select **"Customizable Run Instance..."**.
3. Enable **Multiple Instances** and set the count to **4 or more**.
4. Under **Feature Tags**, ensure you have:
   - Exactly **one** "gateway-server" tag.
   - Exactly **one** "master-server" tag.
   - Exactly **one** "world-server" tag.
   - At least **one or more** "client" tags.
5. (Optional) Under **Launch Arguments**:
   - For servers, add **--headless** to prevent empty windows.
   - For any, add **--config=config_file_path.cfg** to use non-default config path.
6. Run the project (Press F5).

Setup example 
(More details here [How to use "Customize Run Instances..."](https://github.com/SlayHorizon/godot-tiny-mmo/wiki/How-to-use-%22Customize-Run-Instances...%22#customize-run-instances)):
<!-- <img width="1200" alt="debug-screenshot" src="https://github.com/user-attachments/assets/cff4dd67-00f2-4dda-986f-7f0bec0a695e"> -->
<img alt="debug-screenshot" src="https://github.com/user-attachments/assets/cff4dd67-00f2-4dda-986f-7f0bec0a695e">