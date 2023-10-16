GDPC                �                                                                         T   res://.godot/exported/133200997/export-1753c997600d68ab5d20ae99fddb15c6-player.scn         o      �5gYv��)O�z7��    P   res://.godot/exported/133200997/export-2ddd04d543d5858e7f20c9299a8b5096-main.scn@      �      �[��r`Ꭻ��y���\    T   res://.godot/exported/133200997/export-cc8bb94e6afbb30fe28c9d0f0e2ec63b-asteroid.scn        7      MJ^
��x��N˕�r��    ,   res://.godot/global_script_class_cache.cfg  �%             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  `)            p��<2ώ�=�F!�5        res://Scenes/asteroid.tscn.remap0$      e       ��p��_T��u�vZ�       res://Scenes/main.tscn.remap�$      a       F�����X�����        res://Scenes/player.tscn.remap  %      c       �-�~�f�y6vf:�#T       res://Scripts/asteroid.gd   �             d�x�t�O$'V�2F       res://Scripts/player.gd �      �      ����/C �T
[�h       res://icon.svg  �%      �      C��=U���^Qu��U3       res://icon.svg.import   `#      �       ��tF�0�j���F�=$       res://project.binaryp*      �      Vr�[�R�lF�_�u�    L	�9����f6RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://Scripts/asteroid.gd ��������      local://CircleShape2D_l17yt [         local://PackedScene_l15ls �         CircleShape2D          E�B         PackedScene          	         names "      	   Asteroid 	   position    script 
   max_speed 
   min_speed    metadata/_edit_group_    Area2D    CollisionShape2D    shape 
   Polygon2D    polygon    	   variants       
     �C  oC             �                         %        ��  �  �  P�  ��  �A  �A  �A  B  @@  �A  ��      node_count             nodes     #   ��������       ����                                                    ����                     	   	   ����   
                conn_count              conns               node_paths              editable_instances              version             RSRC&~�����ERSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene    res://Scenes/player.tscn u�/l_y    PackedScene    res://Scenes/asteroid.tscn �>g��u      local://PackedScene_3v5kx L         PackedScene          	         names "   	      Main    Node    Player 	   position 	   Asteroid 
   Asteroid2 
   Asteroid3 
   Asteroid4 
   Asteroid5    	   variants                 
     _D  �B         
    �D  �C      node_count             nodes     5   ��������       ����                ���                            ���                           ���                      ���                      ���                      ���                    conn_count              conns               node_paths              editable_instances              version             RSRC�	_�,s���Z,RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Scripts/player.gd ��������      local://PackedScene_km6d5          PackedScene          	         names "         Player 	   position    scale    script 
   max_speed    accel_coeff    rotate_speed    velocity_damp    metadata/_edit_group_    Area2D    CollisionPolygon2D 	   rotation    polygon 
   Polygon2D    	   variants       
    @D  �C
     @@  @@             �     �  )   �Q���?)   �������?      
     �   A   �ɿ%                 A  �A  �A       A  @@%                 A  @@  �A       A  �A      node_count             nodes     1   ��������	       ����                                                                
   
   ����            	      
                     ����            	                   conn_count              conns               node_paths              editable_instances              version             RSRC*extends Area2D

@export var max_speed = 1000;
@export var min_speed = 40;
@export var velocity = Vector2.ZERO;
@export var heading = Vector2.ZERO;
var screen_size;
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size;
	heading = Vector2((randf()*2)-1,(randf()*2)-1).normalized();
	velocity = heading*(max_speed-min_speed)+(min_speed*sign(heading))
	$Polygon2D.color = Color.from_hsv(randf(),0.5,0.9);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	
	if position.x > screen_size.x:
		position.x = 0;
	if position.y > screen_size.y:
		position.y = 0;
	if position.x < 0:
		position.x = screen_size.x;
	if position.y < 0:
		position.y = screen_size.y;
extends Area2D

@export var max_speed = 400;
@export var accel_coeff = 10;
@export var rotate_speed = 0.1; # How many radians the player will rotate per frame when turning
@export var velocity_damp = 0.25; # Velocity damping coefficient (between 0-1)
var heading = Vector2.UP;
var velocity = Vector2.ZERO;
var acceleration = Vector2.ZERO;
var screen_size;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size;
	print(screen_size);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acceleration = Vector2.ZERO;
	
	if Input.is_action_pressed("boost"):
		acceleration += heading;
	if Input.is_action_pressed("rotate_left"):
		heading.x = heading.x * cos(-rotate_speed) - heading.y * sin(-rotate_speed);
		heading.y = heading.x * sin(-rotate_speed) + heading.y * cos(-rotate_speed);
	if Input.is_action_pressed("rotate_right"):
		heading.x = (heading.x * cos(rotate_speed) - heading.y * sin(rotate_speed));
		heading.y = (heading.x * sin(rotate_speed) + heading.y * cos(rotate_speed));
		
	acceleration = acceleration.normalized() * accel_coeff;
	velocity += acceleration*delta;
	# velocity.clamp(Vector2.ZERO,Vector2(max_speed,max_speed));
	
	position += velocity * delta;
	velocity *= pow(velocity_damp, delta);
	rotation = heading.angle();
	
	# Eventually this will probably be moved to be controlled by the main game controller rather than the player,
	# as it will apply to all on-screen objects and not just the player.
	if position.x > screen_size.x:
		position.x = 0;
	if position.y > screen_size.y:
		position.y = 0;
	if position.x < 0:
		position.x = screen_size.x;
	if position.y < 0:
		position.y = screen_size.y;
�kGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ "��eҿ�/���[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dv4kgbhbw3cmn"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 R��V]��`�
R!�>'[remap]

path="res://.godot/exported/133200997/export-cc8bb94e6afbb30fe28c9d0f0e2ec63b-asteroid.scn"
�}��������[remap]

path="res://.godot/exported/133200997/export-2ddd04d543d5858e7f20c9299a8b5096-main.scn"
۪r@�'|]��Dm�[remap]

path="res://.godot/exported/133200997/export-1753c997600d68ab5d20ae99fddb15c6-player.scn"
=>���q�V��g/�list=Array[Dictionary]([])
��ܷ�<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
��4���^�   Mx͜E�x   res://icon.svgu�/l_y    res://player.tscn�T��m�Km   res://main.tscn�>g��u   res://asteroid.tscn�>g��u   res://Scripts/asteroid.tscn�>g��u   res://Scenes/asteroid.tscn�T��m�Km   res://Scenes/main.tscnu�/l_y    res://Scenes/player.tscn�RȰX5"ECFG	      application/config/name      	   Asteroids      application/run/main_scene          res://Scenes/main.tscn     application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg     display/window/stretch/mode         canvas_items   input/rotate_left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/rotate_right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/boost�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/shoot8               deadzone      ?      events         J