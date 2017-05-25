defmodule RMT.Web.RoastView do
  use RMT.Web, :view
  alias RMT.Web.RoastView

  def render("index.json", %{roast: roast}) do
    %{data: render_many(roast, RoastView, "roast.json")}
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
