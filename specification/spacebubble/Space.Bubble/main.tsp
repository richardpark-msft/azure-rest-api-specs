import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.contoso.com/common/oauth2/v2.0/authorize",
      scopes: ["https://widget.contoso.com/.default"],
    }
  ]>
)
@service(#{
  title: "Space.Bubble service",
})
@versioned(Space.Bubble.Versions)
namespace Space.Bubble;

@doc("The Space.Bubble service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2022-11-01-preview version of the Space.Bubble service.")
  `2022-11-01-preview`,
}

@doc("A widget.")
@resource("widgets")
model Widget {
  @key("widgetName")
  @doc("The widget name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The ID of the manufacturer.")
  manufacturerId: string;

  @doc("The faked shared model.")
  sharedModel?: FakedSharedModel;
}

@doc("Faked shared model")
model FakedSharedModel {
  @doc("The tag.")
  tag: string;

  @doc("The created date.")
  createdDate: utcDateTime;
}

@doc("Error response")
model ErrorResponse {
  @doc("Error details")
  error: {
    @doc("Error code")
    code: string;
    
    @doc("Error message")
    message: string;
  };
}

interface Widgets {
  @doc("Fetch a Widget by name.")
  getWidget is ResourceRead<Widget>;

  @doc("Creates or replaces a Widget.")
  createOrReplaceWidget is ResourceCreateOrReplace<Widget>;

  @doc("Delete a Widget.")
  deleteWidget is ResourceDelete<Widget>;

  @doc("List Widget resources")
  listWidgets is ResourceList<Widget>;
}
