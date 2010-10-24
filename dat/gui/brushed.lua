--[[
   The new "brushed" UI.
--]]

function create()
   
   --Get Player
   pp = player.pilot()
   pp = player.pilot()
   pfact = pp:faction()
   pname = player.name()
   pship = pp:ship()
   
   --Get sizes
   screen_w, screen_h = gfx.dim()
   deffont_h = gfx.fontSize()
   smallfont_h = gfx.fontSize(true)
   
   --Colors
   col_shield = colour.new( 24/255, 31/255, 80/255 )
   col_armour = colour.new( 52/255, 52/255, 52/255 )
   col_energy = colour.new( 23/255, 80/255, 33/255 )
   col_fuel   = colour.new( 80/255, 24/255, 37/255 )
   col_heat   = colour.new( 80/255, 27/255, 24/255 )
   col_heat2  = colour.new(181/255, 34/255, 26/255 )
   col_ammo   = colour.new(159/255, 93/255, 15/255 )
   col_top_shield = colour.new(  88/255,  96/255, 156/255 )
   col_top_armour = colour.new( 122/255, 122/255, 122/255 )
   col_top_energy = colour.new(  52/255, 172/255,  71/255 )
   col_top_fuel   = colour.new( 156/255,  88/255, 104/255 )
   col_top_heat   = colour.new( 188/255,  63/255,  56/255 )
   col_top_heat2  = colour.new( 238/255, 143/255, 138/255 )
   col_top_ammo   = colour.new( 233/255, 131/255,  21/255 )
   col_text = colour.new( 203/255, 203/255, 203/255 )
   col_unkn = colour.new( 130/255, 130/255, 130/255 )
   
   --Images
   local base = "gfx/gui/brushed/"
   main = tex.open( base .. "main.png" )
   ext_right = tex.open( base .. "extRight.png" )
   end_right = tex.open( base .. "endRight.png" )
   popup_bottom = tex.open( base .. "popupBottom.png" )
   popup_bottom_side_left = tex.open( base .. "tooltipRightSideLeft.png" )
   popup_bottom2 = tex.open( base .. "tooltipRightBottom.png" )
   popup_body = tex.open( base .. "tooltipRight.png" )
   popup_top = tex.open( base .. "tooltipRightTop.png" )
   popup_empty = tex.open( base .. "tooltipEmpty.png" )
   popup_pilot = tex.open( base .. "pilotFrame.png" )
   bar_bg = tex.open( base .. "barBg.png" )
   bar_frame_light = tex.open( base .. "barFrameLight.png" )
   bar_frame = tex.open( base .. "barFrame.png" )
   bar_light = tex.open( base .. "light.png" )
   bar_sheen = tex.open( base .. "barSheen.png" )
   bar_light = tex.open( base .. "light.png" )
   bar_lock = tex.open( base .. "lock.png" )
   icon_shield = tex.open( base .. "iconShield.png" )
   icon_armour = tex.open( base .. "iconArmour.png" )
   icon_energy = tex.open( base .. "iconEnergy.png" )
   icon_fuel = tex.open( base .. "iconFuel.png" )
   icon_Kinetic = tex.open( base .. "kinetic.png" )
   icon_Radiation = tex.open( base .. "nuclear.png" )
   icon_EMP = tex.open( base .. "ion.png" )
   icon_Energy = tex.open( base .. "plasma.png" )
   icon_Ion = tex.open( base .. "laser.png" )
   icon_missile = tex.open( base .. "missile.png" )
   icon_projectile = tex.open( base .. "projectile.png" )
   icon_beam = tex.open( base .. "beam.png" )
   icon_weapon2 = tex.open( base .. "weapon2.png" )
   icon_weapon1 = tex.open( base .. "weapon1.png" )
   icon_pnt_target = tex.open( base .. "iconPntTarg.png" )
   icon_nav_target = tex.open( base .. "iconNavTarg.png" )
   icon_money = tex.open( base .. "iconMoney.png" )
   icon_cargo = tex.open( base .. "iconCargo.png" )
   field_bg_left = tex.open( base .. "fieldBgLeft1.png" )
   field_bg_center1 = tex.open( base .. "fieldBgCenter1.png" )
   field_bg_center2 = tex.open( base .. "fieldBgCenter2.png" )
   field_bg_right1 = tex.open( base .. "fieldBgRight1.png" )
   field_bg_right2 = tex.open( base .. "fieldBgRIght2.png" )
   field_frame_left = tex.open( base .. "fieldFrameLeft.png" )
   field_frame_center = tex.open( base .. "fieldFrameCenter.png" )
   field_frame_right = tex.open( base .. "fieldFrameRight.png" )
   field_sheen_left = tex.open( base .. "fieldSheenLeft.png" )
   field_sheen = tex.open( base .. "fieldSheen.png" )
   target_bg = tex.open( base .. "targetBg.png" )
   target_frame = tex.open( base .. "targetFrame.png" )
   target_sheen = tex.open( base .. "targetSheen.png" )
   question = tex.open( base .. "question.png" )
   speed_light = tex.open( base .. "speedOn.png" )
   speed_light_off = tex.open( base .. "speedOff.png" )
   top_bar = tex.open( base .. "topbar.png" )
   gui.targetPlanetGFX( tex.open( base .. "radar_planet.png" ) )
   gui.targetPilotGFX(  tex.open( base .. "radar_ship.png" ) )
   
   
   --Positions
   --Main is at 0,0
   
   --Radar
   radar_x = 263
   radar_y = 5
   radar_w = 114
   radar_h = 120
   gui.radarInit( false, radar_w, radar_h )
   
   bar_y = 2
   bar_x = 46
   bar_w, bar_h = bar_bg:dim()
   bars = { "shield", "armour", "energy", "fuel" }
   for k,v in ipairs( bars ) do
      _G[ "x_" .. v ] = bar_x + (k-1)*(bar_w + 6)
      _G[ "y_" .. v ] = bar_y
   end
   
   target_bar_x = 57
   target_bar_y = 92
   bars_target = { "target_shield", "target_armour", "target_energy" }
   for k, v in ipairs( bars_target ) do
      _G[ "x_" .. v ] = target_bar_x + (k-1)*(bar_w + 6)
      _G[ "y_" .. v ] = target_bar_y
   end
   
   target_image_x = 53
   target_image_y = 172
   target_image_w, target_image_h = target_bg:dim()
   question_w, question_h = question:dim()
   
   x_name = 102
   y_name = 197
   
   _, field_h = field_bg_left:dim()
   
   x_dist = 102
   y_dist = 172
   
   x_speed = 189
   y_speed = 173
   
   right_side_x = 406
   left_side_w, left_side_h = main:dim()
   end_right_w, end_right_h = end_right:dim()
   popup_left_x = 42
   popup_left_y = 88
   popup_right_x = 432
   popup_right_y = 88
   
   weapbars = math.floor((screen_w - left_side_w - end_right_w + 10)/(bar_w + 6)) --number of weapon bars that can fit on the screen

   tbar_center_x = screen_w/2
   tbar_center_w = 260
   _, tbar_h = top_bar:dim()
   tbar_y = screen_h - tbar_h
   
   gui.viewport( 0, 0, screen_w, tbar_y + 10 )
   
   fields_y = tbar_y + 15
   if screen_w <=1024 then
      fields_w = (screen_w-tbar_center_w)/4-8
      fields_x = 0
   else
      fields_w = (1024-tbar_center_w)/4-8
      fields_x = (screen_w - 1024)/2
   end
   --Messages
   gui.mesgInit( screen_w - 400, 20, screen_h - 360 )
   
    -- Set FPS
   gui.fpsPos( 30, screen_h - 30 - deffont_h )

   -- Set OSD
   gui.osdInit( 30, screen_h - 30, 150, 300 )
   
   update_target()
   update_ship()
   update_system()
   update_nav()
   update_cargo()
end

function update_target()
   ptarget = pp:target()
   if ptarget ~= nil then
      ta_gfx = ptarget:ship():gfxTarget()
      ta_gfx_w, ta_gfx_h = ta_gfx:dim()
      ta_fact = ptarget:faction()
      ta_stats = ptarget:stats()
      
      ta_gfx_aspect = ta_gfx_w / ta_gfx_h
      
      if ta_gfx_aspect >= 1 then
         if ta_gfx_w > target_image_w then
            ta_gfx_draw_w = target_image_w
            ta_gfx_draw_h = target_image_w / ta_gfx_w * ta_gfx_h
         else
            ta_gfx_draw_w = ta_gfx_w
            ta_gfx_draw_h = ta_gfx_h
         end
      else
         if ta_gfx_h > target_h then
            ta_gfx_draw_h = target_image_w
            ta_gfx_draw_w = target_image_w / ta_gfx_h * ta_gfx_w
         else
            ta_gfx_draw_w = ta_gfx_w
            ta_gfx_draw_h = ta_gfx_h
         end
      end
   end
end

function update_nav()
   nav_pnt, nav_hyp = pp:nav()
   autonav_hyp = player.autonavDest()
end

function update_cargo()
   cargo = pp:cargoFree()
end

function update_ship()
   stats = pp:stats()
end

function update_system()
end

function renderBar( name, value, light, locked, prefix )
   local offsets = { 2, 2, 4, 54, 12, -2 } --Bar/Icon x, Bar y, Sheen x, Sheen y, light x, light y
   
   local vars = { "col", "col_top", "x", "y", "icon" }
   for _,v in ipairs( vars ) do 
      if (v == "x" or v == "y") and prefix ~= nil then
         _G[ "l_" .. v ] = _G[ v .. "_" .. prefix .. "_" .. name ]
      else
         _G[ "l_" .. v ] = _G[ v .. "_" .. name ]
      end
   end
   icon_w, icon_h = l_icon:dim()
   
   if locked == true then
      gfx.renderTex( bar_lock, l_x + offsets[1], l_y + offsets[2] ) --Lock
   else
      gfx.renderTex( bar_bg, l_x + offsets[1], l_y + offsets[2] ) --Background
      gfx.renderRect( l_x + offsets[1], l_y + offsets[2], bar_w, value/100. * bar_h, l_col ) --Bar
      if value < 100 then
         gfx.renderRect( l_x + offsets[1], l_y + offsets[2] + value/100. * bar_h, bar_w, 1, l_col_top ) --lighter area
      end
   end
   gfx.renderTex( l_icon, l_x + offsets[1], l_y + offsets[2] + bar_h/2 - icon_h/2 ) --Icon
   if light ~= false then
      gfx.renderTex( bar_frame_light, l_x, l_y ) --Frame
      if value < 20 then
         gfx.renderTex( bar_light, l_x + offsets[5], l_y + offsets[6] ) --Warning light
      end
   else
      gfx.renderTex( bar_frame, l_x, l_y ) --Frame
   end
   gfx.renderTex( bar_sheen, l_x + offsets[3], l_y + offsets[4] ) --Sheen
end

function renderWeapBar( weapon, x, y )
   local offsets = { 2, 2, 4, 54, 13, 23, 47 } --third last is y of icon_weapon1, last two are the centers of the two weapon icons
   if weapon ~= nil then
      if weapon.ammo ~= nil then
         width = bar_w/2
      else
          width = bar_w
      end
      if weapon.temp <= 1 then
         heatcol = col_heat
         heatcol_top = col_top_heat
      else
         heatcol = col_heat2
         heatcol_top = col_top_heat2
      end
      
      if weapon.dtype ~= "Unknown" then
         top_icon = _G[ "icon_" .. weapon.dtype ]
      else
         top_icon = icon_Kinetic
      end
      
      if weapon.type == "Bolt Cannon" or weapon.type == "Bolt Turret" then
         bottom_icon = icon_projectile
      elseif weapon.type == "Beam Cannon" or weapon.type == "Beam Turret" then
         bottom_icon = icon_beam
      elseif weapon.type == "Launcher" or weapon.type == "Turret Launcher" then
         bottom_icon = icon_missile
      end
      top_icon_w, top_icon_h = top_icon:dim()
      bottom_icon_w, bottom_icon_h = bottom_icon:dim()
      gfx.renderTex( bar_bg, x + offsets[1], y + offsets[2] ) --Background
      gfx.renderRect( x + offsets[1], y + offsets[2], width, weapon.temp/2 *bar_h, heatcol ) --Heat bar, mandatory
      if weapon.temp < 2 then
      gfx.renderRect( x + offsets[1], y + offsets[2] + weapon.temp/2 * bar_h, width, 1, heatcol_top ) --top bit
      end
      if weapon.ammo ~= nil then
         gfx.renderRect( x + offsets[1] + width, y + offsets[2], width, weapon.left_p * bar_h, col_ammo ) --Ammo bar, only if applicable
         if weapon.left_p < 1 then
            gfx.renderRect( x + offsets[1] + width, y + offsets[2] + weapon.left_p * bar_h, width, 1, col_top_ammo ) --top bit
         end
      
         --Icon
         gfx.renderTex( icon_weapon2, x + offsets[1], y + offsets[2] )
      else
         --Icon
         gfx.renderTex( icon_weapon1, x + offsets[1], y + offsets[5] )
      end
      --Weapon-specific Icon
      gfx.renderTex( top_icon, x + offsets[1] + bar_w/2 - top_icon_w/2, y + offsets[2] + offsets[7] - top_icon_h/2 )
      gfx.renderTex( bottom_icon, x + offsets[1] + bar_w/2 - bottom_icon_w/2, y + offsets[2] +  offsets[6] - bottom_icon_h/2 )
   else
      gfx.renderTex( bar_lock, x + offsets[1], y + offsets[2] )
   end

   gfx.renderTex( bar_frame, x, y ) --Frame
   gfx.renderTex( bar_sheen, x + offsets[3], y + offsets[4] )
end

function renderField( text, x, y, w, col, icon )
   local offsets = { 3, 14, 6 } --Sheen x and y, Icon x
   local onetwo = 1
   
   gfx.renderTex( field_bg_left, x, y )
   drawn_w = 14
   while drawn_w < w - 14 do
      gfx.renderTex( _G[ "field_bg_center" .. tostring(onetwo) ], x + drawn_w, y )
      if onetwo == 1 then
         onetwo = 2
      else
         onetwo = 1
      end
      drawn_w = drawn_w + 2
   end
   gfx.renderTex( _G[ "field_bg_right" .. tostring(onetwo) ], x + w - 14, y )
   
   if icon ~= nil then
      local icon_w, icon_h = icon:dim()
      gfx.renderTex( icon, x + offsets[3], y + 11 - icon_h/2 )
      gfx.print( true, text, x+offsets[3]+icon_w+2, y+field_h/2-smallfont_h/2, col, w-(offsets[3]+icon_w+2), true )
   else
      gfx.print( true, text, x, y + field_h/2 - smallfont_h/2, col, w, true )
   end
   
   --gfx.renderTex( field_frame, x, y ) --Frame
   
   gfx.renderTex( field_frame_left, x, y )
   if w > 28 then
      gfx.renderTexRaw( field_frame_center, x+14, y, w-28, field_h, 1, 1, 0, 0, 1, 1 )
   end
   if w >= 28 then
      gfx.renderTex( field_frame_right, x+w-14, y )
   else
      gfx.renderTex( field_frame_right, x+14, y )
   end
   
   --gfx.renderTex( field_sheen, x + offsets[1], y + offsets[2] ) --Sheen
   gfx.renderTex( field_sheen_left, x + offsets[1], y + offsets[2] )
   gfx.renderTexRaw( field_sheen, x + offsets[1] + 6, y + offsets[2], w - (2*offsets[1]+6), 6, 1, 1, 0, 0, 1, 1 )
end

function render( dt )
   
   --Values
   armour, shield = pp:health()
   energy = pp:energy()
   absfuel = player.fuel()
   fuel = absfuel / stats.fuel * 100
   wset_name, wset = pp:weapset( true )
   credits, credits_h = player.credits(2)
   
   --Main window right
   if #wset > weapbars then
      wbars_right = weapbars
   else
      wbars_right = #wset
   end
   right_side_w = (bar_w + 6)*wbars_right - 1
   gfx.renderTexRaw( ext_right, left_side_w - 10, 0, right_side_w, end_right_h, 1, 1, 0, 0, 1, 1 )
   gfx.renderTex( end_right, right_side_x + right_side_w, 0 )
   
   for k=1,wbars_right do
      renderWeapBar( wset[k], right_side_x + 6 + (k-1)*(bar_w + 6), bar_y )
   end
   if wbars_right ~= #wset then
      --Draw a popup of (theoretically) arbitrary size.
      amount = #wset - wbars_right
      height = math.ceil(amount/3. ) * (bar_h+6) - 3
      gfx.renderTex( popup_bottom2, popup_right_x, popup_right_y )
      gfx.renderTex( popup_top, popup_right_x, popup_right_y + 6 + height )
      gfx.renderTexRaw( popup_body, popup_right_x, popup_right_y + 6, 165, height, 1, 1, 0, 0, 1, 1 )
      gfx.renderTex( popup_bottom_side_left, popup_right_x + 7, popup_right_y )
      gfx.renderTexRaw( popup_bottom_side_left, popup_right_x + 158, popup_right_y, -3, 19, 1, 1, 0, 0, 1, 1 )
      
      local drawn
      for i=1, (amount+1) do
         local x = (i-1) % 3 * (bar_w+6) + popup_right_x + 14
         local y = math.floor( (i-1) / 3. ) * (bar_h+6) + 3 + popup_right_y
         renderWeapBar( wset[ wbars_right + i ], x, y )
      end
      for i=(amount+1), math.ceil( amount/3. )*3 do
         local x = (i-1) % 3 * (bar_w+6) + popup_right_x + 14
         local y = math.floor( (i-1) / 3. ) * (bar_h+6) + 3 + popup_right_y
         renderWeapBar( nil, x, y )
      end
      gfx.renderTex( popup_bottom, popup_right_x, popup_right_y - 5 )
   end
   
   --Main window left
   gfx.renderTex( main, 0, 0 )
   gui.radarRender( radar_x, radar_y )
   for k, v in ipairs( bars ) do --bars = { "shield", "armour", "energy", "fuel" }, remember?
      renderBar( v, _G[v] )
   end
   
   --Popup right
   --gfx.renderTex( popup_empty, popup_left_x, popup_left_y )
   --gfx.renderTex( popup_bottom, popup_left_x, popup_left_y - 5 )
   
   --Popup left
   if ptarget ~= nil then
      ta_detect, ta_fuzzy = pp:inrange(ptarget)
      
      if ta_detect then
         gfx.renderTex( popup_pilot, popup_left_x, popup_left_y ) --Frame
         
         --Target Image
         gfx.renderTex( target_bg, target_image_x, target_image_y )
         ta_dist = pp:pos():dist(ptarget:pos())
         if not ta_fuzzy then
            ta_armour, ta_shield = ptarget:health()
            ta_energy = ptarget:energy()
            ta_name = ptarget:name()
            gfx.renderTexRaw( ta_gfx, target_image_x + target_image_w/2 - ta_gfx_draw_w/2, target_image_y + target_image_h/2 - ta_gfx_draw_h/2, ta_gfx_draw_w, ta_gfx_draw_h, 1, 1, 0, 0, 1, 1 )
            renderBar( "shield", ta_shield, false, false, "target" )
            renderBar( "armour", ta_armour, false, false, "target" )
            renderBar( "energy", ta_energy, false, false, "target" )
            renderField( ta_name, x_name, y_name, 86, col_text )
            renderField( tostring( math.floor(ta_dist) ), x_dist, y_dist, 86,col_text )
         else
            gfx.renderTex( question, target_image_x + target_image_w/2 - question_w/2, target_image_y + target_image_h/2 - question_h/2 )
            renderBar( "shield", 0, false, true, "target" )
            renderBar( "armour", 0, false, true, "target" )
            renderBar( "energy", 0, false, true, "target" )
            renderField( "Unknown", x_name, y_name, 86, col_unkn )
            renderField( tostring( math.floor(ta_dist) ), x_dist, y_dist, 86, col_text )
         end
         
         gfx.renderTex( target_frame, target_image_x, target_image_y )
         gfx.renderTex( target_sheen, target_image_x + 3, target_image_y + 32 )
         
         --Speed Lights
         local value = math.floor( ptarget:vel():mod() * 7 / ta_stats.speed )
         if value > 7 then value=7 end
         for i=1, value do
            gfx.renderTex( speed_light, x_speed - 5, y_speed - 3 + (i-1)*6 )
         end
         if value < 7 then
            for i=value+1, 7 do
            gfx.renderTex( speed_light_off, x_speed, y_speed + (i-1)*6 )
            end
         end
      else
         gfx.renderTex( popup_empty, popup_left_x, popup_left_y )
      end
   else
      gfx.renderTex( popup_empty, popup_left_x, popup_left_y )
   end   
   gfx.renderTex( popup_bottom, popup_left_x, popup_left_y - 5 )
   
   --Top Bar
   gfx.renderTexRaw( top_bar, 0, tbar_y, screen_w, tbar_h, 1, 1, 0, 0, 1, 1 )
   
   if nav_pnt ~= nil then
      renderField( nav_pnt:name(), fields_x + 4, fields_y, fields_w, col_text, icon_pnt_target )
   else
      renderField( "None", fields_x + 4, fields_y, fields_w, col_unkn, icon_pnt_target )
   end
   if autonav_hyp ~= nil then
      renderField( autonav_hyp:name() .. " (" .. tostring(autonav_hyp:jumpDist()) .. ")", fields_x + fields_w + 12, fields_y, fields_w, col_text, icon_nav_target )
   else
      renderField( "None", fields_x + fields_w + 12, fields_y, fields_w, col_unkn, icon_nav_target )
   end
   renderField( credits_h, tbar_center_x + tbar_center_w/2 + 4, fields_y, fields_w, col_text, icon_money )
   renderField( tostring(cargo) .. "t", tbar_center_x + tbar_center_w/2 + fields_w + 12, fields_y, fields_w, col_text, icon_cargo )
end