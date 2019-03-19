import postgresql

from config import DATABASE_PATH

from .auth import Auth as _Auth
from .aspects import Aspects as _Aspects
from .favorite import Favorite as _Favorite
from .rewards import Rewards as _Rewards
from .users import Users as _Users, Education as _Education

DATABASE = postgresql.open(DATABASE_PATH)
# DATABASE = 1

Auth = _Auth(DATABASE)
Aspects = _Aspects(DATABASE)
Favorite = _Favorite(DATABASE)
Users = _Users(DATABASE)
Education = _Education(DATABASE)
Rewards = _Rewards(DATABASE)
