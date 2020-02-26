//Procedures in this file: Facial reconstruction surgery
//////////////////////////////////////////////////////////////////
//						FACE SURGERY							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/face
	priority = 2
	can_infect = 0
	var/face_step = 0

/datum/surgery_step/face/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/affected, checks_only)
	if(target_zone != "mouth")
		return 0
	if(affected.status & LIMB_DESTROYED)
		return 0
	var/obj/limb/head/H = affected
	if(!istype(H) || !H.disfigured || H.face_surgery_stage != face_step)
		return 0
	return 1

/datum/surgery_step/face/cut_face
	allowed_tools = list(
	/obj/item/tool/surgery/scalpel = 100,		\
	/obj/item/tool/kitchen/knife = 75,	\
	/obj/item/shard = 50, 		\
	)

	min_duration = SCALPEL_MIN_DURATION
	max_duration = SCALPEL_MAX_DURATION
	face_step = 0

/datum/surgery_step/face/cut_face/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_NOTICE("[user] starts to cut open [target]'s face and neck with \the [tool]."), \
	SPAN_NOTICE("You start to cut open [target]'s face and neck with \the [tool]."))
	..()

/datum/surgery_step/face/cut_face/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_NOTICE("[user] has cut open [target]'s face and neck with \the [tool].") , \
	SPAN_NOTICE("You have cut open [target]'s face and neck with \the [tool]."),)
	affected.face_surgery_stage = 1

/datum/surgery_step/face/cut_face/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_WARNING("[user]'s hand slips, slicing [target]'s throat wth \the [tool]!") , \
	SPAN_WARNING("Your hand slips, slicing [target]'s throat wth \the [tool]!") )
	affected.createwound(CUT, 60)
	target.losebreath += 10
	target.updatehealth()
	affected.update_wounds()


/datum/surgery_step/face/mend_vocal
	allowed_tools = list(
	/obj/item/tool/surgery/hemostat = 100,         \
	/obj/item/stack/cable_coil = 75,         \
	/obj/item/device/assembly/mousetrap = 10 //I don't know. Don't ask me. But I'm leaving it because hilarity.
	)

	min_duration = HEMOSTAT_MIN_DURATION
	max_duration = HEMOSTAT_MAX_DURATION
	face_step = 1

/datum/surgery_step/face/mend_vocal/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_NOTICE("[user] starts mending [target]'s vocal cords with \the [tool]."), \
	SPAN_NOTICE("You start mending [target]'s vocal cords with \the [tool]."))
	..()

/datum/surgery_step/face/mend_vocal/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_NOTICE("[user] mends [target]'s vocal cords with \the [tool]."), \
	SPAN_NOTICE("You mend [target]'s vocal cords with \the [tool]."))
	affected.face_surgery_stage = 2

/datum/surgery_step/face/mend_vocal/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_WARNING("[user]'s hand slips, clamping [target]'s trachea shut for a moment with \the [tool]!"), \
	SPAN_WARNING("Your hand slips, clamping [user]'s trachea shut for a moment with \the [tool]!"))
	target.losebreath += 10
	target.updatehealth()


/datum/surgery_step/face/fix_face
	allowed_tools = list(
	/obj/item/tool/surgery/retractor = 100,          \
	/obj/item/tool/crowbar = 55,             \
	/obj/item/tool/kitchen/utensil/fork = 75
	)

	min_duration = RETRACTOR_MIN_DURATION
	max_duration = RETRACTOR_MAX_DURATION
	face_step = 2

/datum/surgery_step/face/fix_face/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_NOTICE("[user] starts pulling the skin on [target]'s face back in place with \the [tool]."), \
	SPAN_NOTICE("You start pulling the skin on [target]'s face back in place with \the [tool]."))
	..()

/datum/surgery_step/face/fix_face/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_NOTICE("[user] pulls the skin on [target]'s face back in place with \the [tool]."),	\
	SPAN_NOTICE("You pull the skin on [target]'s face back in place with \the [tool]."))
	affected.face_surgery_stage = 3

/datum/surgery_step/face/fix_face/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_WARNING("[user]'s hand slips, tearing skin on [target]'s face with \the [tool]!"), \
	SPAN_WARNING("Your hand slips, tearing skin on [target]'s face with \the [tool]!"))
	target.apply_damage(10, BRUTE, affected, sharp = 1)
	target.updatehealth()


/datum/surgery_step/face/cauterize
	allowed_tools = list(
	/obj/item/tool/surgery/cautery = 100,			\
	/obj/item/clothing/mask/cigarette = 75,	\
	/obj/item/tool/lighter = 50,    \
	/obj/item/tool/weldingtool = 25
	)

	min_duration = CAUTERY_MIN_DURATION
	max_duration = CAUTERY_MAX_DURATION
	face_step = 3


/datum/surgery_step/face/cauterize/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_NOTICE("[user] is beginning to cauterize the incision on [target]'s face and neck with \the [tool].") , \
	SPAN_NOTICE("You are beginning to cauterize the incision on [target]'s face and neck with \the [tool]."))
	..()

/datum/surgery_step/face/cauterize/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_NOTICE("[user] cauterizes the incision on [target]'s face and neck with \the [tool]."), \
	SPAN_NOTICE("You cauterize the incision on [target]'s face and neck with \the [tool]."))
	affected.remove_all_bleeding(TRUE)
	affected.disfigured = 0
	affected.owner.name = affected.owner.get_visible_name()
	affected.face_surgery_stage = 0

/datum/surgery_step/face/cauterize/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, obj/limb/head/affected)
	user.visible_message(SPAN_WARNING("[user]'s hand slips, leaving a small burn on [target]'s face with \the [tool]!"), \
	SPAN_WARNING("Your hand slips, leaving a small burn on [target]'s face with \the [tool]!"))
	target.apply_damage(4, BURN, affected)
	target.updatehealth()
