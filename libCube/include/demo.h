struct Demo {
    void build_image_ownership_cmd(const SwapchainImageResources &swapchain_image_resource);
    vk::Bool32 check_layers(const std::vector<const char *> &check_names, const std::vector<vk::LayerProperties> &layers);
    void cleanup();
    void destroy_swapchain_related_resources();
    void create_device();
    void destroy_texture(texture_object &tex_objs);
    void draw();
    void draw_build_cmd(const SwapchainImageResources &swapchain_image_resource);
    void prepare_init_cmd();
    void flush_init_cmd();
    void init(int argc, char **argv);
    void init_connection();
    void init_vk();
    void init_vk_swapchain();
    void prepare();
    void prepare_buffers();
    void prepare_cube_data_buffers();
    void prepare_depth();
    void prepare_descriptor_layout();
    void prepare_descriptor_pool();
    void prepare_descriptor_set();
    void prepare_framebuffers();
    vk::ShaderModule prepare_shader_module(const uint32_t *code, size_t size);
    vk::ShaderModule prepare_vs();
    vk::ShaderModule prepare_fs();
    void prepare_pipeline();
    void prepare_render_pass();
    void prepare_texture_image(const char *filename, texture_object &tex_obj, vk::ImageTiling tiling, vk::ImageUsageFlags usage,
                               vk::MemoryPropertyFlags required_props);
    void prepare_texture_buffer(const char *filename, texture_object &tex_obj);
    void prepare_textures();

    void resize();
    void create_surface();
    void set_image_layout(vk::Image image, vk::ImageAspectFlags aspectMask, vk::ImageLayout oldLayout, vk::ImageLayout newLayout,
                          vk::AccessFlags srcAccessMask, vk::PipelineStageFlags src_stages, vk::PipelineStageFlags dest_stages);
    void update_data_buffer();
    bool loadTexture(const char *filename, uint8_t *rgba_data, vk::SubresourceLayout &layout, uint32_t &width, uint32_t &height);
    bool memory_type_from_properties(uint32_t typeBits, vk::MemoryPropertyFlags requirements_mask, uint32_t &typeIndex);
    vk::SurfaceFormatKHR pick_surface_format(const std::vector<vk::SurfaceFormatKHR> &surface_formats);

    static VKAPI_ATTR VkBool32 VKAPI_CALL debug_messenger_callback(VkDebugUtilsMessageSeverityFlagBitsEXT messageSeverity,
                                                                   VkDebugUtilsMessageTypeFlagsEXT messageType,
                                                                   const VkDebugUtilsMessengerCallbackDataEXT *pCallbackData,
                                                                   void *pUserData);

#if defined(VK_USE_PLATFORM_WIN32_KHR)
    void run();
    void create_window();
#elif defined(VK_USE_PLATFORM_XLIB_KHR)
    void create_xlib_window();
    void handle_xlib_event(const XEvent *event);
    void run_xlib();
#elif defined(VK_USE_PLATFORM_XCB_KHR)
    void handle_xcb_event(const xcb_generic_event_t *event);
    void run_xcb();
    void create_xcb_window();
#elif defined(VK_USE_PLATFORM_WAYLAND_KHR)
    void run();
    void create_window();
#elif defined(VK_USE_PLATFORM_DIRECTFB_EXT)
    void handle_directfb_event(const DFBInputEvent *event);
    void run_directfb();
    void create_directfb_window();
#elif defined(VK_USE_PLATFORM_METAL_EXT)
    void run();
#elif defined(VK_USE_PLATFORM_DISPLAY_KHR)
    vk::Result create_display_surface();
    void run_display();
#endif

    std::string name = "vkcubepp";  // Name to put on the window/icon
#if defined(VK_USE_PLATFORM_WIN32_KHR)
    HINSTANCE connection = nullptr;  // hInstance - Windows Instance
    HWND window = nullptr;           // hWnd - window handle
    POINT minsize = {0, 0};          // minimum window size
#elif defined(VK_USE_PLATFORM_XLIB_KHR)
    Window xlib_window = 0;
    Atom xlib_wm_delete_window = 0;
    Display *display = nullptr;
#elif defined(VK_USE_PLATFORM_XCB_KHR)
    xcb_window_t xcb_window = 0;
    xcb_screen_t *screen = nullptr;
    xcb_connection_t *connection = nullptr;
    xcb_intern_atom_reply_t *atom_wm_delete_window = nullptr;
#elif defined(VK_USE_PLATFORM_WAYLAND_KHR)
    wl_display *display = nullptr;
    wl_registry *registry = nullptr;
    wl_compositor *compositor = nullptr;
    wl_surface *window = nullptr;
    xdg_wm_base *wm_base = nullptr;
    zxdg_decoration_manager_v1 *xdg_decoration_mgr = nullptr;
    zxdg_toplevel_decoration_v1 *toplevel_decoration = nullptr;
    xdg_surface *window_surface = nullptr;
    bool xdg_surface_has_been_configured = false;
    xdg_toplevel *window_toplevel = nullptr;
    wl_seat *seat = nullptr;
    wl_pointer *pointer = nullptr;
    wl_keyboard *keyboard = nullptr;
#elif defined(VK_USE_PLATFORM_DIRECTFB_EXT)
    IDirectFB *dfb = nullptr;
    IDirectFBSurface *window = nullptr;
    IDirectFBEventBuffer *event_buffer = nullptr;
#elif defined(VK_USE_PLATFORM_METAL_EXT)
    void *caMetalLayer;
#endif

    vk::SurfaceKHR surface;
    bool prepared = false;
    bool use_staging_buffer = false;
    bool use_xlib = false;
    bool separate_present_queue = false;
    bool invalid_gpu_selection = false;
    int32_t gpu_number = 0;

    vk::Instance inst;
    vk::DebugUtilsMessengerEXT debug_messenger;
    vk::PhysicalDevice gpu;
    vk::Device device;
    vk::Queue graphics_queue;
    vk::Queue present_queue;
    uint32_t graphics_queue_family_index = 0;
    uint32_t present_queue_family_index = 0;
    std::array<vk::Semaphore, FRAME_LAG> image_acquired_semaphores;
    std::array<vk::Semaphore, FRAME_LAG> draw_complete_semaphores;
    std::array<vk::Semaphore, FRAME_LAG> image_ownership_semaphores;
    vk::PhysicalDeviceProperties gpu_props;
    std::vector<vk::QueueFamilyProperties> queue_props;
    vk::PhysicalDeviceMemoryProperties memory_properties;

    std::vector<const char *> enabled_instance_extensions;
    std::vector<const char *> enabled_layers;
    std::vector<const char *> enabled_device_extensions;

    uint32_t width = 0;
    uint32_t height = 0;
    vk::Format format;
    vk::ColorSpaceKHR color_space;

    vk::SwapchainKHR swapchain;
    std::vector<SwapchainImageResources> swapchain_image_resources;
    vk::PresentModeKHR presentMode = vk::PresentModeKHR::eFifo;
    std::array<vk::Fence, FRAME_LAG> fences;
    uint32_t frame_index = 0;

    vk::CommandPool cmd_pool;
    vk::CommandPool present_cmd_pool;

    struct {
        vk::Format format;
        vk::Image image;
        vk::MemoryAllocateInfo mem_alloc;
        vk::DeviceMemory mem;
        vk::ImageView view;
    } depth;

    static int32_t const texture_count = 1;
    std::array<texture_object, texture_count> textures;
    texture_object staging_texture;

    struct {
        vk::Buffer buf;
        vk::MemoryAllocateInfo mem_alloc;
        vk::DeviceMemory mem;
        vk::DescriptorBufferInfo buffer_info;
    } uniform_data;

    vk::CommandBuffer cmd;  // Buffer for initialization commands
    vk::PipelineLayout pipeline_layout;
    vk::DescriptorSetLayout desc_layout;
    vk::PipelineCache pipelineCache;
    vk::RenderPass render_pass;
    vk::Pipeline pipeline;

    mat4x4 projection_matrix = {};
    mat4x4 view_matrix = {};
    mat4x4 model_matrix = {};

    float spin_angle = 0.0f;
    float spin_increment = 0.0f;
    bool pause = false;

    vk::ShaderModule vert_shader_module;
    vk::ShaderModule frag_shader_module;

    vk::DescriptorPool desc_pool;
    vk::DescriptorSet desc_set;

    std::vector<vk::Framebuffer> framebuffers;

    bool quit = false;
    uint32_t curFrame = 0;
    uint32_t frameCount = 0;
    bool validate = false;
    bool in_callback = false;
    bool use_debug_messenger = false;
    bool use_break = false;
    bool suppress_popups = false;
    bool force_errors = false;

    uint32_t current_buffer = 0;
};
