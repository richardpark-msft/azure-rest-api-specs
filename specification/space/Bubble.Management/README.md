# Azure Space Bubble Management Service

This directory contains the TypeSpec definition for the Azure Space Bubble Management service.

## What is Azure Space Bubble?

Azure Space Bubble is a fictional service for managing space bubbles in Azure. It provides APIs to create, manage, and monitor space bubbles with various properties like diameter, coordinates, and operational status.

## API Version

Current API version: `2024-01-01`

## TypeSpec Structure

- `main.tsp` - Contains the main TypeSpec definitions for the service
- `client.tsp` - Contains client customization configurations
- `tspconfig.yaml` - TypeSpec project configuration
- `examples/` - Contains API operation examples

## Resources

### SpaceBubble

A space bubble resource with the following properties:
- **diameter**: The diameter of the space bubble in meters
- **status**: The operational status (Creating, Active, Expanding, Contracting, Inactive, Deleting)
- **coordinates**: 3D coordinates in space (x, y, z)
- **provisioningState**: The Azure resource provisioning state

## Operations

The service supports standard Azure Resource Manager operations:
- GET (retrieve a space bubble)
- PUT (create or update a space bubble)
- PATCH (update a space bubble)
- DELETE (delete a space bubble)
- LIST (list space bubbles by resource group or subscription)

## Generated Output

When compiled, this TypeSpec generates OpenAPI specifications that can be found in:
`specification/space/resource-manager/Microsoft.SpaceBubble/stable/2024-01-01/spacebubble.json`
