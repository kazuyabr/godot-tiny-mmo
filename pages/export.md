> [!NOTE]  
> This guide can also be used for other multiplayer projects using a dedicated server approach.

# Exporting the Project

This Godot project contains both server and client components in the same codebase. However, when exporting, you'll typically want to exclude the server side from the client build and vice versa. This guide explains how to organize and export the project properly for both the server and the client.

## Project Structure

The project is structured to facilitate easy separation of the client and server. Below is the folder organization:

- **assets/**  
  Contains graphical, audio, and other non-Godot-related files that are shared by both the client and server.
  
- **client/**  
  Contains all the client-specific resources and scripts.
  
- **common/**  
  Contains shared resources, scripts, and logic between the server and the client.
  
- **server/**  
  Contains all the server-specific resources and scripts.

## Exporting the Server

To export the server side, you only need to include the following folders:

- `assets/`
- `common/`
- `server/`

When exporting, ensure you select **"Export as dedicated server"**. This option strips unnecessary graphical components, making the server build more lightweight and efficient.

![Export Server Screenshot](https://github.com/user-attachments/assets/6d6501c7-7ca7-442d-9609-499498c0b640)

## Exporting the Client

For the client side, export the following folders:

- `assets/`
- `common/`
- `client/`

This setup ensures that only the client-related code and resources are included in the client build.

![Export Client Screenshot](https://github.com/user-attachments/assets/0836599f-94b3-43ca-9aaa-dcf8ce5465fa)

## Additional Tips

- **Automation:** If you find yourself exporting the client and server builds frequently, consider setting up an automation script to streamline the process.
  
- **Testing:** Ensure that both the client and server builds are thoroughly tested in their respective environments before deployment.

By following this organization and export process, you can efficiently manage and deploy your Godot project for both server and client with minimal overhead.
