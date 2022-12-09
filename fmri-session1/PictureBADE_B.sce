###YES-NO VERSION OF PICTURE BADE FOR MCT###

scenario="PictureBADE_B";
pcl_file = "PictureBADE_B.pcl";
#scenario_type = fMRI_emulation; # set for debugging
scenario_type=fMRI; # set for testing
no_logfile = false; # set for testing
active_buttons = 3;
button_codes = 1, 2, 9;
scan_period = 2000; # TR
pulses_per_scan = 1;
pulse_code = 1;
pulse_width=indefinite_port_code;

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

bitmap {filename="BADEscreenshot.bmp";} screenshot;

picture {text fixation;	x = 0; y = $img_y;}fixation_pic;

picture{
	bitmap screenshot; x=0; y=0;
	text {caption="Index finger
			for yes"; 
		font_size=18;
		font="arial";
	}instructions_txtL; x=-250; y=0;
	text {caption="Middle finger  
			for no"; 
		font_size=18;
		font="arial";
	}instructions_txtR; x=250; y=0;
	text {caption="INSTRUCTIONS";
		font_size=18;
		font="arial";
	}instrct; x = 0; y = 255;
}instructions_pic1;

picture{
	bitmap screenshot; x=0; y=0;
	text instructions_txtL; x=-250; y=0;
	text instructions_txtR; x=250; y=0;
	text {caption="STARTING...";
			font_size=16;
			font="arial";
			}starting; x = 0; y = 255;
}instructions_pic2;

######################
##TRIAL DECLARATIONS##
######################

trial{
	trial_type = specific_response;
	trial_duration = forever;
	terminator_button = 3;
	stimulus_event{
		picture instructions_pic1;
	}instructions_event;
}instructions_trial;

trial {
	picture instructions_pic2;
	code = "start_trial";
	duration = 1000;
	mri_pulse = 1; # set for testing
}start_trial;

trial{
	all_responses = false; # responses made in this trial will be ignored
stimulus_event{
	picture {text{caption = "5"; font_size = 44;} five; x = 0; y = $img_y;};
		duration = 1000;};
stimulus_event{
	picture {text{caption = "4"; font_size = 44;} four; x = 0; y = $img_y;};
		deltat = 1000;
		duration = 1000;};
stimulus_event{
	picture {text{caption = "3"; font_size = 44;} three; x = 0; y = $img_y;};
		deltat = 1000;
		duration = 1000;};
stimulus_event{
	picture {text{caption = "2"; font_size = 44;} two; x = 0; y = $img_y;};
		deltat = 1000;
		duration = 1000;};
stimulus_event{
	picture {text {caption = "1"; font_size = 40;} one; x = 0; y = $img_y;};
		deltat = 1000;
		duration = 1000;};
}countdown_trial;

trial {
	all_responses = false; # responses made in this trial will be ignored
	picture fixation_pic;
	code = "fixation";
	duration = 1000;
}fixation_trial;

trial{
	trial_type = first_response;
	trial_duration = 4000;
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
	save_logfile {};
	
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