from .public import Register
from .public import Login
from .public import Profile
from .public import Education
from .public import Rewards
from .public import FavoriteAspects
from .public import FavoriteUsers
from .public import Discussion, CreateDiscussion, Aspects, Arguments
from .public import Knowledge

from .public import Tesis, TesisSource
from .public import Feedback
from .public import Mute as isMute
from .public import LikesUser
from .public import LikesComment
from .public import TopUsers
from .public import Rewards
from .public import Claims


from .admin import GetClaim
from .admin import KnowladgeReset
from .admin import EducationVerefizied
from .admin import ProfileVerefizied
from .admin import AMute
from .admin import GeneralMarks
from .admin import RewardsUpdate
from .admin import Argument
from .admin import Alerts
from .admin import User


routes = [
    {
        'component': Register,
        'path': '/api/public/register'
    },
    {
        'component': Login,
        'path': '/api/public/login'
    },
    {
        'component': Profile,
        'path': '/api/public/profile/<id>'
    },
    {
        'component': Rewards,
        'path': '/api/public/profile/<id>/rewards'
    },
    {
        'component': Knowledge,
        'path': '/api/public/profile/<id>/knowledge'
    },
    {
        'component': Education,
        'path': '/api/public/profile/<id>/education'
    },
    {
        'component': FavoriteAspects,
        'path': '/api/public/profile/<id>/favorite/aspects'
    },
    {
        'component': FavoriteUsers,
        'path': '/api/public/profile/favorite/users'
    },
    {
        'component': CreateDiscussion,
        'path': '/api/public/discussions'
    },
    {
        'component': Discussion,
        'path': '/api/public/discussions/<id>'
    },
    {
        'component': Aspects,
        'path': '/api/public/discussions/<id>/aspects'
    },
    {
        'component': Arguments,
        'path': '/api/public/discussions/<id>/arguments'
    },
    {
        'component': Feedback,
        'path': '/api/public/feedback'
    },



    {
        'component': Tesis,
        'path': '/api/public/tesis/<id>'  
    },
    {
        'component': TesisSource,
        'path': '/api/public/tesis_source/<id>'  
    },
    {
        'component': TopUsers,
        'path': '/api/publick/top_users'
    },

    
    #improve algo 
    {
        'component': LikesUser,
        'path': '/api/publick/likes/user/<id>' #user id /  user id who we like 
    },
    {
        'component': LikesComment,
        'path': '/api/publick/likes/comment/<id>'#user id /  comment id which we like 
    },
    {
        'component': Claims,
        'path': '/api/publick/claims/<id>'# tesis id / title description
    },
    
    {
        'component': isMute,
        'path': '/api/public/ismute/<id>' # get user id   
    },
    #admin




    { 
        'component': Alerts,
        'path': '/api/admin/alerts/<id>'#id of aleert
    },
    { 
        'component': Argument,
        'path': '/api/admin/argument/<id>'#delete
    },

    { 
        'component': GetClaim,
        'path': '/api/admin/claims/<id>'#get tesis id / delete claim id
    },
    
    { 
        'component': GeneralMarks,
        'path': '/api/admin/gen_marks/<country>'#get country id
    },
    { 
        'component': KnowladgeReset,
        'path': '/api/admin/knoladge_reset'
    },
    { 
        'component': AMute,
        'path': '/api/admin/mute/<id>'#user id 
    },

    { 
        'component': RewardsUpdate,
        'path': '/api/admin/rewards/<id>'#user id /  reward id
    },
    
    { 
        'component': User,
        'path': '/api/admin/user/<id>'#user id / country, city , hight_school , faculty , specialty , date 
    },
    { 
        'component': EducationVerefizied,
        'path': '/api/admin/education_vereficied/<id>'#user id 
    },
    { 
        'component': ProfileVerefizied,
        'path': '/api/admin/profile_vereficied/<id>'#user id / post  verefizied_statement bool
    }
]