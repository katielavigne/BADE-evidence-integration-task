###YES-NO VERSION OF PICTURE BADE FOR MCT###

scenario="PictureBADE_A";
pcl_file = "PictureBADE_A.pcl";
#scenario_type = fMRI_emulation; # set for debugging
scenario_type=fMRI; # set for testing
no_logfile = false; # set for testing
active_buttons = 2;
button_codes = 1, 2;
scan_period = 2000; # TR
pulses_per_scan = 1;
pulse_code = 7;

response_logging = log_active; # prevents responses in trials with "all_responses = false" from being included in logfile

default_background_color=0,0,0; 
default_font="arial";
default_font_size = 28;
default_text_color = 255,255,255;

begin;

###########################
###VARIABLE DECLARATIONS###
###########################

$text_x='0';
$text_y='-25';
$img_x='0';
$img_y='125';
$box_outline_height='30';
$box_outline_width='30';
$yes_x='-50';
$no_x='50';
$rating_y='-75';

###########################
###GRAPHICS DECLARATIONS###
###########################

box{height = $box_outline_height; width = $box_outline_width; color = 255, 255, 255;} rating_outline; #outline for rating boxes
box{height = '$box_outline_height-5'; width = '$box_outline_width-5'; color = 0, 0, 0;} rating_no; # colours of rating boxes are modified 
box{height = '$box_outline_height-5'; width = '$box_outline_width-5'; color = 0, 0, 0;} rating_yes; # when rating is made (black to white)

text {
   caption = "+";
   font_size = 40;
   }fixation;

########################
##PICTURE DECLARATIONS##
########################

picture {} default;

picture {text fixation;	x = 0; y = $img_y;}fixation_pic;

trial {
	all_responses = false; # responses made in this trial will be ignored
	picture fixation_pic;
	code = "fixation";
	duration = 1000;
}fixation_trial;

trial{
	trial_type = first_response;
	trial_duration = 2000;
	#trial_duration = forever; # for debugging
	stimulus_event{
	picture {text {caption = "debug your pcl file"; } img_txt ;	x=$text_x ; y=$text_y;
				bitmap { filename = "acorn_img3.png"; preload = true; height = 225; scale_factor = scale_to_height;} img ; x=$img_x;y=$img_y;
				box rating_outline; x = $yes_x; y = $rating_y;
				box rating_outline; x = $no_x; y = $rating_y;
				box rating_yes; x = $yes_x; y = $rating_y;
				box rating_no; x = $no_x; y = $rating_y;
				text {caption = "YES"; font_size = 20;} yes; x = $yes_x; y = '$rating_y-50';
				text {caption = "NO"; font_size = 20;} no; x = $no_x; y = '$rating_y-50';
	}pic;
	code = "debug"; # modified in PCL
	}pic_picture_event;
}generic_pic_trial;

trial{
	trial_duration = 1000; # modified in PCL based on RTs
	picture pic;
}response_trial_event;

trial {
	all_responses = false; # responses made in this trial will be ignored
	stimulus_event{ 
		picture fixation_pic;
		code = "ITI";
	} ITI_event;
}ITI_trial;

trial{
	trial_duration = 1000;
	all_responses = false; # responses made in this trial will be ignored
	
	stimulus_event{
	picture {text img_txt ;	x=$text_x ; y=$text_y;
				bitmap img ; x=$img_x;y=$img_y;
	}finalpic;
	code = "debug";
	}finalpic_picture_event;
}generic_finalpic_trial;

trial {
	all_responses = false; # responses made in this trial will be ignored
	picture {text{caption = "Thank you. Please remember to stay still
until the scanner stops.";}; x = 0; y = 0;}finished;
	code = "thanks";
	duration = 10000;
}end_trial;