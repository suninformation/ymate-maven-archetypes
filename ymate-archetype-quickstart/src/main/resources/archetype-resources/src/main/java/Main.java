#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package};

import net.ymate.platform.core.IApplication;
import net.ymate.platform.core.YMP;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Open Sesame!
 *
 * @author YMP (<a href="https://www.ymate.net/">ymate.net</a>)
 */
public class Main {

    static {
        System.setProperty(IApplication.SYSTEM_MAIN_CLASS, Main.class.getName());
    }

    private static final Log LOG = LogFactory.getLog(Main.class);

    public static void main(String[] args) throws Exception {
        try (IApplication application = YMP.run(args)) {
            if (application.isInitialized()) {
                LOG.info("Everything depends on ability!  -- YMP :)");
            }
        }
    }
}
