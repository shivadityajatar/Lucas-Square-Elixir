defmodule Proj1 do

use GenServer

  def start_link() do
    arg = System.argv()
    {:ok,pid} = GenServer.start_link(Proj1,arg)
    {pid}
  end

  def init(initial_data) do
    values = initial_data
    m = Enum.at(initial_data, 0)
    n = Enum.at(initial_data, 1)
    m = String.to_integer(m)
    n = String.to_integer(n)
    Worker.spawnActors(0,m,n)
    {:ok,values}
  end

  def jobAssign(count) do
    count = count+1;
    count
  end

end

defmodule Worker do

  def spawnActors(count, limit, size) do
    if count === limit+1 do
      :break
    else
      new = Proj1.jobAssign(count)
      spawn(__MODULE__, :printf, [new,size])
      spawnActors(new, limit,size)
    end
  end

  def printf(count,size) do
    sqroot = :math.sqrt(Enum.sum(Enum.map(Enum.to_list(count..count+size-1), fn x -> x * x end)))
    sqr = Float.ceil(sqroot,0)
    if (sqr - sqroot)>0 do
    else
      IO.puts "Ans #{count}"
    end
  end

end

Proj1.start_link()
