#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package};

import net.ymate.platform.core.IApplication;
import net.ymate.platform.core.YMP;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.lang3.StringUtils;

/**
 * Open Sesame!
 *
 * @author YMP (https://www.ymate.net/)
 */
public class Main {

    static {
        String mainClass = System.getProperty(IApplication.SYSTEM_MAIN_CLASS);
        if (StringUtils.isBlank(mainClass)) {
            System.setProperty(IApplication.SYSTEM_MAIN_CLASS, Starter.class.getName());
        }
    }

    private static final Log LOG = LogFactory.getLog(Main.class);

    public static void main(String[] args) throws Exception {
        LOG.info("Everything depends on ability!  -- YMP :)");
        net.ymate.platform.core.container.Main.main(args);
    }
}
