defmodule IssuesWeb.PageController do
  use IssuesWeb, :controller

	alias Issues.GithubIssues

  def index(conn, _params) do
    render(conn, "index.html")
  end

	def show(conn, %{"issues_search" => %{ "user" => user, "project" => project }}) do
		IO.puts "Checking for issues.... #{user}::#{project}"
		case GithubIssues.get_issues_for_user_and_project(user, project) do
			{:ok, issues} ->
				IO.inspect issues
				render(conn, "show.html", %{user: user, project: project, issues: issues})

			_ -> render(conn, "index.html")
		end
		# conn
		# |> render(conn, "show.html", %{user: user, project: project})

		# render(conn, "show.html", %{user: user, project: project})
	end
end
