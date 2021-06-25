defmodule TeamworkWeb.CreateTeamComponent do
  use TeamworkWeb, :live_component
  require Logger
  alias Teamwork.Schema.Team
  alias Teamwork.TeamAdministration

  @impl true
  def mount(socket) do
    {:ok,
     assign(socket,
       new_team: Team.new()
     )}
  end

  @impl true
  def handle_event("create_team", %{"team" => params}, socket) do
    updated_socket =
      socket.assigns.current_user
      |> TeamAdministration.create_team(params)
      |> case do
        {:ok, %{team: team}} ->
          send(self(), {:team_added, team})
          assign(socket, new_team: Team.new())
      end

    {:noreply, updated_socket}
  end

  def handle_event("validate_team", %{"team" => params}, socket) do
    {:noreply, assign(socket, new_team: Team.new(params))}
  end

  @impl true
  def render(assigns) do
    ~L"""
      <div class="w-full lg:w-1/2 my-6 pr-0 lg:pr-2">
          <p class="text-xl pb-6 flex items-center">
              <i class="fas fa-list mr-3"></i> Create Team
          </p>
          <div class="leading-loose">
            <%= form_for @new_team, "#", [phx_change: :validate_team, phx_submit: :create_team, phx_target: @myself, class: "p-10 bg-white rounded shadow-xl"], fn form -> %>
                <div class="">
                    <label class="block text-sm text-gray-600" for="name">Team Name</label>
                    <%= text_input(
                          form,
                          :name,
                          [
                            id: "name",
                            required: "true",
                            placeholder: "Team Name",
                            "aria-label": "Team Name",
                            autocomplete: "off",
                            spellcheck: "false",
                            class: "w-full px-5 py-1 text-gray-700 bg-gray-200 rounded"
                          ]
                    ) %>
                </div>
                <div class="mt-6">
                  <%= submit(
                        "Create",
                         [
                           phx_disable_with: "Creating...",
                           class: "px-4 py-1 text-white font-light tracking-wider bg-gray-900 rounded"
                         ]
                  ) %>
                </div>
            <% end %>
          </div>
      </div>
    """
  end
end
