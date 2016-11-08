 
module Type.Blorg.Config exposing(..)

forReactor : Bool
forReactor = False

apiHost : String
apiHost = case forReactor of
               True -> "http://localhost:4000"
               False -> ""
