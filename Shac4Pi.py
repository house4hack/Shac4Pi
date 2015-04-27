#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# PyGtalkRobot: A simple jabber/xmpp bot framework using Regular Expression Pattern as command controller
# Copyright (c) 2008 Demiao Lin <ldmiao@gmail.com>
#
# RaspiBot: A simple software robot for Raspberry Pi based on PyGtalkRobot
# Copyright (c) 2013 Michael Mitchell <michael@mitchtech.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# PyGtalkRobot Homepage: http://code.google.com/p/pygtalkrobot/
# RaspiBot Homepage: http://code.google.com/p/pygtalkrobot/
#
# ######################################
# This implementation of the RaspiBot is : Shac4Pi
# 
# Developed by Philip Booysen <philipbooysen@gmail.com>
# Fri Apr 24 14:20:09 SAST 2015

# Shac = Smart House Access Control by House4Hack
# Objective : Fire up a XMPP based python client on a Raspberry Pi Model B (version 1)
#             such that it is able to persistently be logged into Gtalk, and such that when
#             commands or GPIO pin high/low commands are sent via XMPP buddies to this
#             account, it would set certain GPIO pins high and low, to actuate and trigger
#             a 2 Channel 5V Relay module such that it can actuate a gate remote or disengage
#             a magnetic lock.

import time
import subprocess
import RPi.GPIO as GPIO
from PyGtalkRobot import GtalkRobot

BOT_GTALK_USER = 'our_shac4pi_user@gmail.com'
BOT_GTALK_PASS = 'ourpassword'
BOT_ADMIN = 'the_bot_admin@gmail.com'

debug=open('/tmp/shac4py.log', 'w+')

#GPIO.setmode(GPIO.BOARD) # or 
GPIO.setmode(GPIO.BCM)
############################################################################################################################

class RaspiBot(GtalkRobot):
    
    #Regular Expression Pattern Tips:
    # I or IGNORECASE <=> (?i)      case insensitive matching
    # L or LOCALE <=> (?L)          make \w, \W, \b, \B dependent on the current locale
    # M or MULTILINE <=> (?m)       matches every new line and not only start/end of the whole string
    # S or DOTALL <=> (?s)          '.' matches ALL chars, including newline
    # U or UNICODE <=> (?u)         Make \w, \W, \b, and \B dependent on the Unicode character properties database.
    # X or VERBOSE <=> (?x)         Ignores whitespace outside character sets
    
    #"command_" is the command prefix, "001" is the priviledge num, "setState" is the method name.
    #This method is used to change the state and status text of the bot.
    def command_001_setState(self, user, message, args):
        #the __doc__ of the function is the Regular Expression of this command, if matched, this command method will be called. 
        #The parameter "args" is a list, which will hold the matched string in parenthesis of Regular Expression.
        '''(available|online|busy|dnd|away|idle|out|xa)( +(.*))?$(?i)'''
        show = args[0]
        status = args[1]
        jid = user.getStripped()

        # Verify if the user is the Administrator of this bot
        if jid == BOT_ADMIN:
            print jid, " ---> ",bot.getResources(jid), bot.getShow(jid), bot.getStatus(jid)
            self.setState(show, status)
            self.replyMessage(user, "State settings changed！")

    #This method opens a specified door
    def command_003_pinOn(self, user, message, args):
        '''(door_open)( +(.*))?$(?i)'''
        door_num = args[1]
        print "About to open a door : "+ door_num +"\n"
        if int(door_num) == 1:
                pin_num=23
        if int(door_num) == 2:
                pin_num=24
        GPIO.setup(int(pin_num), GPIO.OUT)
        GPIO.output(int(pin_num), True)
        self.replyMessage(user, "\nOpening door: "+ door_num +" at: "+time.strftime("%Y-%m-%d %a %H:%M:%S", time.localtime()))
        # sleep for 10 seconds here
        time.sleep(10)
        GPIO.setup(int(pin_num), GPIO.OUT)
        GPIO.output(int(pin_num), False)


    #This method is the default response
    def command_100_default(self, user, message, args):
        '''.*?(?s)(?m)'''
        self.replyMessage(user, time.strftime("%Y-%m-%d %a %H:%M:%S", time.localtime()))

############################################################################################################################
if __name__ == "__main__":
    bot = RaspiBot()
    bot.setState('available', "Raspi Gtalk Robot")
    bot.start(BOT_GTALK_USER, BOT_GTALK_PASS)
