import imgui
from imgui.integrations.pygame import PygameRenderer
import pygame
import sys
import OpenGL.GL as gl

import var
from menus.home import build as buildHome
from menus.aston import build as buildAstonMenu
from menus.ticker import build as buildTickerMenu
from menus.playout import build as buildPlayoutMenu
from menus.branding import build as buildBrandingMenu
from menus.identity  import build as buildIdentityMenu
from menus.automation import build as buildAutomationMenu

pygame.init()
size = 1280, 720

pygame.display.set_mode(size, pygame.DOUBLEBUF | pygame.OPENGL | pygame.RESIZABLE)

imgui.create_context()
impl = PygameRenderer()

io = imgui.get_io()
sans = io.fonts.add_font_from_file_ttf(
    "fonts/reith/sans/regular.ttf", 16,
)
impl.refresh_font_texture()
io.display_size = size
pygame.display.set_caption('VizHelper')
icon = pygame.image.load('img/viz2.0.webp')
pygame.display.set_icon(icon)


while 1:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            sys.exit(0)
        impl.process_event(event)
    impl.process_inputs()

    imgui.new_frame()
    
    with imgui.font(sans):
        imgui.show_test_window()
        buildHome()
        if var.showAstonControls:
            buildAstonMenu()
        if var.showTickerControls:
            buildTickerMenu()
        if var.showPlayoutControls:
            buildPlayoutMenu()
        if var.showBrandingControls:
            buildBrandingMenu()
        if var.showTickerControls:
            buildIdentityMenu()
        if var.showAutomationControls:
            buildAutomationMenu()

    
    gl.glClearColor(0, 0, 0, 1)
    gl.glClear(gl.GL_COLOR_BUFFER_BIT)
    imgui.render()
    impl.render(imgui.get_draw_data())
    pygame.display.flip()