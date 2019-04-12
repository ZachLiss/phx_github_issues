defmodule IssuesWeb.PageController do
  use IssuesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
