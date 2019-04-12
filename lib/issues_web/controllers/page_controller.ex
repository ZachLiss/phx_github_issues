defmodule IssuesWeb.PageController do
  use IssuesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

	def show(conn, %{"issues_search" => %{ "user" => user, "project" => project }}) do

		# IO.puts params
		# render(conn, "show.html", %{user: "zach", project: "test project"})
		render(conn, "show.html", %{user: user, project: project})
	end
end
