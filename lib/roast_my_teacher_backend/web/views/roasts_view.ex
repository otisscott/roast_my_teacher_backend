defmodule RMT.Web.RoastsView do
  use RMT.Web, :view
  alias RMT.Web.RoastsView

  def render("index.json", %{roasts: roasts}) do
    %{data: render_many(roasts, RoastsView, "roasts.json")}
  end

  def render("show.json", %{roasts: roasts}) do
    %{data: render_one(roasts, RoastsView, "roasts.json")}
  end

  def render("roasts.json", %{roasts: roasts}) do
    %{id: roasts.id,
      rating: roasts.rating,
      comment: roasts.comment}
  end
end
