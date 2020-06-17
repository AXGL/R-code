library(devtools)
install_github("tylermorganwall/coronaobj")
library(coronaobj)
library(rayrender)
write_corona_obj("defaults.obj")

obj_model("defaults.obj", vertex_colors = TRUE) %>%
  add_object(sphere(y=10,z=10,x=10, material=light(intensity=100))) %>%
  add_object(sphere(y=10,z=10,x=-10, material=light(intensity=100))) %>%
  render_scene(parallel=TRUE, samples = 10, fov = 7, min_variance=0, focal_distance = 9.6,
               width=800,height=800, filename = "SARS-COV-2.png")

#更改配色

write_corona_obj("custom_color.obj",
                 color_membrane = "cadetblue1",
                 color_spike = "steelblue",
                 color_open_spike = "deepskyblue1")



obj_model("custom_color.obj", vertex_colors = TRUE) %>%
  add_object(sphere(y=10,z=10,x=10, material=light(color="lightblue",intensity=100))) %>%
  add_object(sphere(y=10,z=10,x=-10, material=light(color="orange",intensity=100))) %>%
  render_scene(parallel=TRUE, samples = 10, fov = 7, min_variance=0, focal_distance = 9.6,
               width=800,height=800,filename = "cov2019.png")

#多个病毒
write_corona_obj("custom_color3.obj", color_membrane = "#ed645c",
                 color_spike = "#a32b24", color_open_spike = "#c91271")

generate_ground(depth=-0.55,material = metal(color="darkred", fuzz=0.025)) %>%
  add_object(obj_model("custom_color3.obj", vertex_colors = TRUE)) %>%
  add_object(obj_model("custom_color3.obj", z=-6,x=0.8,y=0.5, angle=c(0,90,0),vertex_colors = TRUE)) %>%
  add_object(obj_model("custom_color3.obj", z=-3,x=-0.5,y=0.2, angle=c(0,180,0), vertex_colors = TRUE)) %>%
  add_object(sphere(y=10,x=-10, material=light(color="white",intensity=100))) %>%
  add_object(sphere(y=0,x=10, material=light(color="purple",intensity=100))) %>%
  render_scene(parallel=TRUE, samples = 10, focal_distance = 9.6, fov=10,
               ambient_light = TRUE, min_variance=0,
               backgroundhigh = "black", backgroundlow = "darkred",
               aperture=0.2, width=800,height=800, clamp_value=10,filename = "cov2019more.png")
