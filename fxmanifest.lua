fx_version 'cerulean'
game 'gta5'
author 'Scorpion'
description 'Prints all of the spawned/deleted vehicles in f8 console'
version '1.0.0'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
client_script 'client.lua'
shared_script '@ox_lib/init.lua'

dependencies{
    'ox_lib',
    '/server:7290',
    '/onesync'
} 