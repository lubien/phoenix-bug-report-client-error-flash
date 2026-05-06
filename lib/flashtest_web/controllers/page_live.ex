defmodule FlashtestWeb.PageLive do
  use FlashtestWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    {:ok, assign(socket, :counter, 0)}
  end

  def handle_info(:tick, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end

  def handle_event("server_error", _params, socket) do
    Process.exit(self(), :kill)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.flash_group flash={@flash} />

    <p>Im pagelive. Counter {@counter}</p>

    <.button type="button" onclick="liveSocket.disconnect()" variant="primary">
      Client error: disconnect me
    </.button>
    <.button type="button" phx-click="server_error">
      Server error: kill liveview
    </.button>
    """
  end
end
