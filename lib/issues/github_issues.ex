defmodule Issues.GithubIssues do
	require Logger
  @moduledoc """
	The GithubIssues Context
	"""

	@user_agent [{"User-agent", "Elixir dave@pragprog.com"}]
	@github_url Application.get_env(:issues, :github_url)

	def get_issues_for_user_and_project(user, project) do
		count = 5
		case fetch(user, project) do
			{:ok, _body} = response ->
				result = response
				|> decode_response
				|> convert_to_list_of_hashdicts
				|> sort_into_ascending_order
				|> Enum.take(count)
				|> prepare_data_for_page
				{:ok, result}
			{:error, msg} -> {:error, msg}
		end

	end

	def prepare_data_for_page(issues) do
		# return list with just the correct properties for each issue
		Enum.map(issues, fn i -> %{ number: i["number"], created_at: i["created_at"], title: i["title"]} end)
	end

	#
	defp fetch(user, project) do
		Logger.info "Fetching user #{user}'s project #{project}"
		Logger.info "using URL: #{issues_url(user, project)}"
		issues_url(user, project) |> HTTPoison.get(@user_agent) |> handle_response
	end

	defp issues_url(user, project) do
		"#{@github_url}/repos/#{user}/#{project}/issues"
	end

	defp handle_response({:ok, %{status_code: 200, body: body}}) do
		Logger.info "Successful response"
		{:ok, :jsx.decode body}
	end
	defp handle_response({:error, %{status_code: status, body: body}}) do
		# Logger.info "Error #{status} returned"
		{:error, :jsx.decode body}
	end
	defp handle_response(error) do
		# Logger.info "Error #{status} returned"
		{:error, "idk something bad happened"}
	end


	# cli.ex
	def decode_response({:ok, body}), do: body
	def decode_response({:error, error}) do
		{_, message} = List.keyfind(error, "message", 0)
		IO.puts "Error fetching from Github: #{message}"
		System.halt 2
	end

	def convert_to_list_of_hashdicts(list) do
		# Enum.map(list, &Enum.into(&1, Map.new)) # this is the code from the book... any reason to use Enum.into here?
		Enum.map(list, &Map.new(&1))
	end

	def sort_into_ascending_order(list_of_issues) do
		Enum.sort list_of_issues, &(&1["created_at"] <= &2["created_at"])
	end

end
