# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blorg.Repo.insert!(%Blorg.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Blorg.Repo

alias Blorg.Article

Repo.insert! %Article {
  title: "Elixir is fast",
  body: "I am serving data in 500 microseconds. While other languages are counting milliseconds or seconds."
}

Repo.insert! %Article {
  title: "Elm is Interactive",
  body: "People are expecting applications. Everybody has a mobile phone. Enough for passive web pages. Web pages are full of troubles like css, javascript. There is no encapsulation"  
}

Repo.insert! %Article {
  title: "Try and Fail Fast",
  body: "Invent and idea on Friday and serve it on Monday on the cloud. People are doing this already."
}

Repo.insert! %Article {
  title: "Program Faster",
  body: "I prepared this demo before the breakfast this morning. This is possible. However, that requires a ninja experience and weeks of exercise"
}

Repo.insert! %Article {
  title: "Connect",
  body: "Connect with the community. Open source learning is a social activity. If you are alone you might miss the point. Or misunderstand many points"
}