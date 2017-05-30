defmodule RMT.API.RoastView do
  use RMT.Web, :view
  alias RMT.API.RoastView

  def render("index.json", %{roasts: roasts}) do
    %{data: render_many(roasts, RoastView, "roast.json")}
  end

  def render("show.json", %{roast: roast}) do
    %{data: render_one(roast, RoastView, "roast.json")}
  end

  def render("roast.json", %{roast: roast}) do
    %{id: roast.id,
      rating: roast.rating,
      comment: roast.comment}
  end
end
