#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package};

import net.ymate.platform.webmvc.annotation.Controller;
import net.ymate.platform.webmvc.annotation.RequestMapping;
import net.ymate.platform.webmvc.base.Type;
import net.ymate.platform.webmvc.view.IView;
import net.ymate.platform.webmvc.view.View;

/**
 * Open Sesame!
 *
 * @author YMP (<a href="https://www.ymate.net/">ymate.net</a>)
 */
@Controller
@RequestMapping("/hello")
public class HelloController {

    @RequestMapping(value = "/", method = {Type.HttpMethod.GET, Type.HttpMethod.POST})
    public IView hello() throws Exception {
        return View.textView("Everything depends on ability!  -- YMP :)");
    }
}
