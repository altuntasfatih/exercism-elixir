defmodule Newsletter do
  def read_emails(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
  end

  def open_log(path), do: File.open!(path, [:write])

  @spec log_sent_email(atom | pid, any) :: :ok
  def log_sent_email(pid, email), do: IO.puts(pid, email)

  @spec close_log(pid | {:file_descriptor, atom, any}) :: :ok | {:error, atom}
  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    log = open_log(log_path)

    read_emails(emails_path)
    |> Enum.each(fn email ->
      with :ok <- send_fun.(email) do
        log_sent_email(log, email)
      end
    end)

    close_log(log)
  end
end
