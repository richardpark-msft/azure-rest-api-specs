import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.Core.Traits;

@armProviderNamespace
@service(#{
  title: "Azure Space Bubble Management",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.SpaceBubble;

/** The available API versions. */
enum Versions {
  /** 2024-01-01 API version */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_01_01: "2024-01-01",
}

interface Operations extends Azure.ResourceManager.Operations {}

/** Space Bubble resource */
@doc("A space bubble resource")
model SpaceBubble is TrackedResource<SpaceBubbleProperties> {
  /** Name of the space bubble */
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("spaceBubbleName")
  @path
  @segment("spaceBubbles")
  name: string;
}

/** Properties of a Space Bubble */
@doc("Properties of a space bubble")
model SpaceBubbleProperties {
  /** The size of the space bubble */
  @doc("The diameter of the space bubble in meters")
  diameter: float64;

  /** The current status of the space bubble */
  @doc("The current operational status of the space bubble")
  status: SpaceBubbleStatus;

  /** The location coordinates of the space bubble */
  @doc("The coordinates of the space bubble in space")
  coordinates: SpaceCoordinates;

  /** The provisioning state of the resource */
  @doc("The provisioning state of the space bubble")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
}

/** Status of a space bubble */
@doc("The operational status of a space bubble")
union SpaceBubbleStatus {
  string,

  /** The space bubble is being created */
  Creating: "Creating",

  /** The space bubble is active and operational */
  Active: "Active",

  /** The space bubble is expanding */
  Expanding: "Expanding",

  /** The space bubble is contracting */
  Contracting: "Contracting",

  /** The space bubble is inactive */
  Inactive: "Inactive",

  /** The space bubble is being deleted */
  Deleting: "Deleting",
}

/** Coordinates in space */
@doc("3D coordinates in space")
model SpaceCoordinates {
  /** X coordinate */
  @doc("X coordinate in space")
  x: float64;

  /** Y coordinate */
  @doc("Y coordinate in space")
  y: float64;

  /** Z coordinate */
  @doc("Z coordinate in space")
  z: float64;
}

/** Space bubble update parameters */
@doc("Parameters for updating a space bubble")
model SpaceBubbleUpdate {
  /** Updatable properties of the space bubble */
  @doc("The properties to update")
  properties?: SpaceBubbleUpdateProperties;
}

/** Updatable properties of a space bubble */
@doc("Updatable properties of a space bubble")
model SpaceBubbleUpdateProperties {
  /** The size of the space bubble */
  @doc("The diameter of the space bubble in meters")
  diameter?: float64;

  /** The location coordinates of the space bubble */
  @doc("The coordinates of the space bubble in space")
  coordinates?: SpaceCoordinates;
}

@armResourceOperations
interface SpaceBubbles {
  /** Get a space bubble */
  get is ArmResourceRead<SpaceBubble>;

  /** Create or update a space bubble */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SpaceBubble>;

  /** Update a space bubble */
  update is ArmResourcePatchSync<SpaceBubble, SpaceBubbleUpdate>;

  /** Delete a space bubble */
  delete is ArmResourceDeleteWithoutOkAsync<SpaceBubble>;

  /** List space bubbles by resource group */
  listByResourceGroup is ArmResourceListByParent<SpaceBubble>;

  /** List space bubbles by subscription */
  listBySubscription is ArmListBySubscription<SpaceBubble>;
}
